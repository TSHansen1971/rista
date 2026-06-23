# ᚼ Rísta

Rísta er et macOS-native startprosjekt for en ren markdown-editor: skriv i ren tekst, se dokumentet formatert fortløpende, og behold dokumentene som åpne `.md`-filer.

Dette repoet er laget som et nøkternt lokalt utviklingsgrunnlag. Det kopierer ikke kode, ikon, tekst, skjermbilder eller andre eiendeler fra Markdown Pro. Det bevarer bare arbeidsideen: tastaturdrevet markdown med side-ved-side forhåndsvisning.

## MVP-kontrakt

Første versjon skal være smal:

- åpne, redigere og lagre vanlige `.md`- og tekstfiler
- skriveflate til venstre og live forhåndsvisning til høyre
- enkel markdown-rendering for overskrifter, avsnitt, lister, sitater, kodeblokker og horisontal strek
- ingen konto, ingen database, ingen synk-tjeneste, ingen AI og ingen proprietært dokumentformat

## Lokal utvikling

Åpne prosjektet direkte i Xcode:

```zsh
cd ~/prosjekter/rista
open Package.swift
```

Eller bygg og test fra terminal:

```zsh
./tools/build_local.zsh
./tools/test_local.zsh
```

Start appen lokalt:

```zsh
./tools/run_local.zsh
```

## Git

Initialiser lokal git-historikk etter at mappen er lagt på riktig sted:

```zsh
./tools/bootstrap_git.zsh
```

Scriptet oppretter `main`, legger til prosjektfilene og forsøker å lage første commit. Det oppretter ikke remote og pusher ingenting.

## Prosjektstruktur

```text
rista/
├── Package.swift
├── README.md
├── Sources/
│   ├── RistaApp/
│   └── RistaCore/
├── Tests/
│   └── RistaCoreTests/
├── docs/
│   ├── 00_governance/
│   ├── 01_product/
│   ├── 02_architecture/
│   └── 03_brand/
├── reports/
└── tools/
```

## Navn og teknisk identitet

Brukerrettet navn: `ᚼ Rísta`.

Teknisk navn: `Rista`.

Dette gjør at produktet kan ha riktig visuell og språklig identitet i brukerflaten, samtidig som repo, bundle, filstier, scripts og tekniske metadata kan være ASCII-vennlige.
