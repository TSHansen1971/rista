# RÍSTA-001 – Arkitektur

## Teknisk grunnform

Prosjektet er et Swift Package-basert macOS-appgrunnlag:

- `RistaApp`: brukerflate og macOS-appstart
- `RistaCore`: dokumentmodell, markdown-normalisering og enkel blokkparser
- `RistaCoreTests`: enhetstester for ren kjernefunksjonalitet

## Editorvalg

Skriveflaten bruker `NSTextView` broet inn i SwiftUI. Det er valgt fordi en seriøs markdown-editor normalt trenger bedre tekstkontroll enn en enkel SwiftUI `TextEditor` gir.

## Previewvalg

Første preview er bevisst enkel og lokal. Den parser grunnleggende markdown-blokker og bruker SwiftUI-visning. Dette gjør første MVP avhengighetsfri og lett å kontrollere.

## Fremtidige vurderinger

Dersom preview senere skal støtte full CommonMark, tabeller, fotnoter eller avansert typografi, bør parser/rendering løftes ut som en egen beslutning.
