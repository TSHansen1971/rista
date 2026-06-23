#!/bin/zsh
unsetopt BANG_HIST 2>/dev/null || true
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin:/Library/Apple/usr/bin:${PATH:-}"

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TEMPLATE="$ROOT/metadata/apple/macos/RistaMacInfo.plist.template"
ICON="$ROOT/Sources/RistaMac/Resources/RistaAppIcon.icns"
OUTPUT_ROOT="$ROOT/.build/rista-macos-app"
APP="$OUTPUT_ROOT/Rista.app"
CONTENTS="$APP/Contents"
MACOS="$CONTENTS/MacOS"
RESOURCES="$CONTENTS/Resources"

fail() {
  echo "FEIL: $1"
  exit 1
}

echo "=== RÍSTA – BUILD MACOS APP BUNDLE ==="
echo "Root: $ROOT"
echo "App:  $APP"
echo ""

cd "$ROOT" || fail "Finner ikke repo root."

[ -f "$TEMPLATE" ] || fail "Mangler metadata-template: $TEMPLATE"
[ -f "$ICON" ] || fail "Mangler appikon: $ICON"

/usr/bin/plutil -lint "$TEMPLATE" >/dev/null || fail "metadata-template er ikke gyldig plist."

echo "=== 1. SWIFT BUILD ==="
swift build

echo ""
echo "=== 2. FINNER BUILD-PRODUKT ==="
BIN_PATH="$(swift build --show-bin-path)"
EXECUTABLE="$BIN_PATH/Rista"

[ -x "$EXECUTABLE" ] || fail "Fant ikke kjørbart produkt: $EXECUTABLE"

echo "Bin path:   $BIN_PATH"
echo "Executable: $EXECUTABLE"

RESOURCE_CANDIDATES=(
  "$BIN_PATH/Rista_RistaMac.resources"
  "$BIN_PATH/Rista_RistaMac.bundle"
)

RESOURCE_BUNDLE=""
for candidate in "${RESOURCE_CANDIDATES[@]}"; do
  if [ -e "$candidate" ]; then
    RESOURCE_BUNDLE="$candidate"
    break
  fi
done

if [ -z "$RESOURCE_BUNDLE" ]; then
  RESOURCE_BUNDLE="$(/usr/bin/find "$BIN_PATH" -maxdepth 1 \( -name "Rista_RistaMac.resources" -o -name "Rista_RistaMac.bundle" \) -print | /usr/bin/head -n 1)"
fi

[ -n "$RESOURCE_BUNDLE" ] || fail "Fant ikke SwiftPM resource bundle for RistaMac i $BIN_PATH"

echo "Resource bundle: $RESOURCE_BUNDLE"

echo ""
echo "=== 3. MATERIALISERER .APP ==="
rm -rf "$APP"
mkdir -p "$MACOS" "$RESOURCES"

cp "$EXECUTABLE" "$MACOS/Rista"
cp "$TEMPLATE" "$CONTENTS/Info.plist"
cp "$ICON" "$RESOURCES/RistaAppIcon.icns"
cp -R "$RESOURCE_BUNDLE" "$RESOURCES/$(basename "$RESOURCE_BUNDLE")"

chmod +x "$MACOS/Rista"

echo ""
echo "=== 4. KONTROLLER INFO.PLIST ==="
/usr/bin/plutil -lint "$CONTENTS/Info.plist"

BUNDLE_ID="$(/usr/bin/plutil -extract CFBundleIdentifier raw "$CONTENTS/Info.plist")"
BUNDLE_NAME="$(/usr/bin/plutil -extract CFBundleName raw "$CONTENTS/Info.plist")"
EXEC_NAME="$(/usr/bin/plutil -extract CFBundleExecutable raw "$CONTENTS/Info.plist")"
ICON_FILE="$(/usr/bin/plutil -extract CFBundleIconFile raw "$CONTENTS/Info.plist")"

[ "$BUNDLE_ID" = "no.tostha.rista" ] || fail "Uventet CFBundleIdentifier: $BUNDLE_ID"
[ "$BUNDLE_NAME" = "Rísta" ] || fail "Uventet CFBundleName: $BUNDLE_NAME"
[ "$EXEC_NAME" = "Rista" ] || fail "Uventet CFBundleExecutable: $EXEC_NAME"
[ "$ICON_FILE" = "RistaAppIcon" ] || fail "Uventet CFBundleIconFile: $ICON_FILE"

echo "OK: Info.plist nøkkelverdier er riktige."

echo ""
echo "=== 5. KONTROLLER BUNDLE-INNHOLD ==="
[ -x "$MACOS/Rista" ] || fail "Mangler Contents/MacOS/Rista"
[ -f "$CONTENTS/Info.plist" ] || fail "Mangler Contents/Info.plist"
[ -f "$RESOURCES/RistaAppIcon.icns" ] || fail "Mangler Contents/Resources/RistaAppIcon.icns"
[ -e "$RESOURCES/$(basename "$RESOURCE_BUNDLE")" ] || fail "Mangler SwiftPM resource bundle i Contents/Resources"

find "$APP" -maxdepth 4 -print | sort

echo ""
echo "=== 6. AD-HOC SIGNERING UTEN ENTITLEMENTS ==="
if command -v codesign >/dev/null 2>&1; then
  /usr/bin/codesign --force --sign - "$APP" >/dev/null 2>&1 || fail "Ad-hoc codesign feilet."
  /usr/bin/codesign --verify --deep --strict "$APP" >/dev/null 2>&1 || fail "codesign verify feilet."
  echo "OK: ad-hoc signert og verifisert uten entitlementsfil."
else
  echo "MERK: codesign ikke funnet. Hopper over signering."
fi

echo ""
echo "=== FERDIG ==="
echo "$APP"
