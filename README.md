# Sanchez-Base

Eine umfangreiche FiveM-Ressource, die verschiedene essenzielle Gameplay-Mechaniken und Systeme für FiveM-Server implementiert.

## Hauptfunktionen

- **Anti-Cheat & Sicherheit**
  - Anti-Troll-System
  - Combat-Log-Schutz
  - Anti-VDM-System
  - Mod-Menü-Erkennung

- **Spieler-Features**
  - Knockout-System
  - Carry-System
  - Sitz-System
  - Holster-System
  - GPS-System
  - Plastische Chirurgie
  - Tattoo-System
  - Rucksack-System für Donator

- **Fahrzeug-Systeme**
  - Legacy Fuel Integration
  - Fahrzeugschloss-System
  - Fahrzeugschaden-System
  - Geschwindigkeitsbegrenzer
  - ELS (Enhanced Lighting System)

- **Wirtschafts-Features**
  - Rechnungssystem
  - Minijob-System
  - Schrottplatz
  - Muschel-Sammelsystem

- **Sicherheitszonen**
  - Safezone-System
  - Sperrzonen-Management
  - Fraktionssperren

## Installation

1. Kopiere den Ordner in dein FiveM-Ressourcen-Verzeichnis
2. Füge folgende Zeile in deine `server.cfg` ein:
```cfg
ensure Sanchez-Base
```

## Konfiguration

Die Konfigurationsdateien befinden sich im `config/`-Verzeichnis:

- `cf_exports.lua` - Haupt-Exports und Funktionen
- `cf_logs.lua` - Logging-Konfiguration
- `cf_holster.lua` - Holster-System-Einstellungen
- `cf_vehicledamage.lua` - Fahrzeugschaden-Einstellungen
- Weitere spezifische Konfigurationsdateien für jedes Modul

## Abhängigkeiten

- ESX Framework
- MySQL-Async
- FiveM-Map-Skript (für Minimap)

