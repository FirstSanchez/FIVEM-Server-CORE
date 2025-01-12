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

## Befehle

### Allgemeine Befehle
- `/plz` - Zeigt die aktuelle Postleitzahl an
- `/sit` - Hinsetzen an der aktuellen Position
- `/carry` - Spieler tragen
- `/gps` - GPS-System öffnen
- `/knockout` - Spieler bewusstlos schlagen
- `/billing` - Rechnung erstellen

### Fahrzeug-Befehle
- `/carlock` - Fahrzeug auf-/abschließen
- `/shuff` - Auf Fahrersitz wechseln
- `/repair` - Fahrzeug reparieren (mit Reparatur-Kit)
- `/speedlimiter` - Geschwindigkeitsbegrenzung aktivieren

### Admin-Befehle
- `/clip` - Durch Wände gehen (Admin)
- `/sperrzone` - Sperrzone erstellen/entfernen
- `/troll` - Troll-Maßnahmen verwalten

## Scriptfunktionen

### Client-Exports
```lua
-- Fahrzeug-Funktionen
exports['Sanchez-Base']:GetFuel(vehicle)
exports['Sanchez-Base']:SetFuel(vehicle, fuel)
exports['Sanchez-Base']:LockVehicle(vehicle)
exports['Sanchez-Base']:UnlockVehicle(vehicle)

-- Spieler-Funktionen
exports['Sanchez-Base']:IsPlayerInSafezone()
exports['Sanchez-Base']:CanPlayerPvP()
exports['Sanchez-Base']:IsPlayerKnockedOut()

-- GPS-Funktionen
exports['Sanchez-Base']:SetGPSRoute(coords)
exports['Sanchez-Base']:ClearGPSRoute()
```

### Server-Exports
```lua
-- Wirtschafts-Funktionen
exports['Sanchez-Base']:CreateBill(playerId, amount, reason)
exports['Sanchez-Base']:AddMoney(playerId, amount)

-- Verwaltungs-Funktionen
exports['Sanchez-Base']:AddToSafezone(coords, radius)
exports['Sanchez-Base']:RemoveFromSafezone(zoneId)
exports['Sanchez-Base']:SetFrakSperre(factionName, status)
```

### Events
```lua
-- Client Events
RegisterNetEvent('Sanchez-Base:onEnterSafezone')
RegisterNetEvent('Sanchez-Base:onLeaveSafezone')
RegisterNetEvent('Sanchez-Base:onVehicleLock')
RegisterNetEvent('Sanchez-Base:onKnockout')

-- Server Events
RegisterNetEvent('Sanchez-Base:billPaid')
RegisterNetEvent('Sanchez-Base:playerDeath')
RegisterNetEvent('Sanchez-Base:combatLog')
```

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

### Webhook-Konfiguration

Die Datei `webhooks.lua` enthält Platzhalter für Discord-Webhooks:
```lua
Config_Sperrzone.Webhook = "WEBHOOK_HERE"
```
Ersetze "WEBHOOK_HERE" mit deinem Discord-Webhook-Link für die entsprechende Funktionalität.

## Abhängigkeiten

- ESX Framework
- MySQL-Async
- FiveM-Map-Skript (für Minimap)

## Lizenz

Alle Rechte vorbehalten. Dieses Projekt ist urheberrechtlich geschützt.

## Support

Bei Fragen oder Problemen wende dich bitte an den Support-Discord.
