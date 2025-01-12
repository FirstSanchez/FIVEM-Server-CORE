# 🎮 Sanchez-Base

<div align="center">
  <h3>Eine umfangreiche FiveM-Ressource für erweiterte Gameplay-Mechaniken</h3>
  <p>Entwickelt für optimale Serverleistung und Spielerfahrung</p>
</div>

---

## 📋 Inhaltsverzeichnis
- [Hauptfunktionen](#-hauptfunktionen)
- [Befehle](#-befehle)
- [Scriptfunktionen](#-scriptfunktionen)
- [Installation](#-installation)
- [Konfiguration](#-konfiguration)
- [Abhängigkeiten](#-abhängigkeiten)
- [Support](#-support)

## 🚀 Hauptfunktionen

### 🛡️ Anti-Cheat & Sicherheit
- **Anti-Troll-System** - Schützt Spieler vor Trolling
- **Combat-Log-Schutz** - Verhindert Combat-Logging
- **Anti-VDM-System** - Stoppt Vehicle-Deathmatch
- **Mod-Menü-Erkennung** - Erkennt und verhindert Cheating

### 👥 Spieler-Features
- **Knockout-System** - Realistisches K.O.-System
- **Carry-System** - Spieler tragen/transportieren
- **Sitz-System** - Erweiterte Sitzmöglichkeiten
- **Holster-System** - Realistisches Waffen-Holster
- **GPS-System** - Fortschrittliche Navigation
- **Plastische Chirurgie** - Charakteranpassung
- **Tattoo-System** - Umfangreiches Tattoo-System
- **Rucksack-System** - Erweitertes Inventar für Donatoren

### 🚗 Fahrzeug-Systeme
- **Legacy Fuel** - Realistisches Tanksystem
- **Fahrzeugschloss** - Sicherheitssystem
- **Fahrzeugschaden** - Detaillierte Schadensmodelle
- **Geschwindigkeitsbegrenzer** - Geschwindigkeitskontrolle
- **ELS** - Enhanced Lighting System

### 💰 Wirtschafts-Features
- **Rechnungssystem** - Digitale Zahlungen
- **Minijob-System** - Zusätzliche Verdienstmöglichkeiten
- **Schrottplatz** - Fahrzeugverwertung
- **Muschel-Sammelsystem** - Sammelaktivität

### 🌍 Sicherheitszonen
- **Safezone-System** - Geschützte Bereiche
- **Sperrzonen** - Zugangsbeschränkungen
- **Fraktionssperren** - Fraktionsbasierte Kontrollen

## ⌨️ Befehle

### 📝 Allgemeine Befehle
\`\`\`
/plz         - Zeigt aktuelle Postleitzahl
/sit         - Hinsetzen
/carry       - Spieler tragen
/gps         - GPS-System öffnen
/knockout    - Spieler bewusstlos schlagen
/billing     - Rechnung erstellen
\`\`\`

### 🚙 Fahrzeug-Befehle
\`\`\`
/carlock     - Fahrzeug auf-/abschließen
/shuff       - Auf Fahrersitz wechseln
/repair      - Fahrzeug reparieren
/speedlimiter- Geschwindigkeitsbegrenzung
\`\`\`

### 👑 Admin-Befehle
\`\`\`
/clip       - Durch Wände gehen (Admin)
/sperrzone  - Sperrzone erstellen/entfernen
/troll      - Anti-Troll-Maßnahmen
\`\`\`

## 🔧 Scriptfunktionen

### 💻 Client-Exports
\`\`\`lua
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
\`\`\`

### 🖥️ Server-Exports
\`\`\`lua
-- Wirtschafts-Funktionen
exports['Sanchez-Base']:CreateBill(playerId, amount, reason)
exports['Sanchez-Base']:AddMoney(playerId, amount)

-- Verwaltungs-Funktionen
exports['Sanchez-Base']:AddToSafezone(coords, radius)
exports['Sanchez-Base']:RemoveFromSafezone(zoneId)
exports['Sanchez-Base']:SetFrakSperre(factionName, status)
\`\`\`

### 📡 Events
\`\`\`lua
-- Client Events
RegisterNetEvent('Sanchez-Base:onEnterSafezone')
RegisterNetEvent('Sanchez-Base:onLeaveSafezone')
RegisterNetEvent('Sanchez-Base:onVehicleLock')
RegisterNetEvent('Sanchez-Base:onKnockout')

-- Server Events
RegisterNetEvent('Sanchez-Base:billPaid')
RegisterNetEvent('Sanchez-Base:playerDeath')
RegisterNetEvent('Sanchez-Base:combatLog')
\`\`\`

## 📥 Installation

1. Kopiere den Ordner in dein FiveM-Ressourcen-Verzeichnis
2. Füge folgende Zeile in deine \`server.cfg\` ein:
\`\`\`cfg
ensure Sanchez-Base
\`\`\`

## ⚙️ Konfiguration

Die Konfigurationsdateien befinden sich im \`config/\`-Verzeichnis:

| Datei | Beschreibung |
|-------|-------------|
| cf_exports.lua | Haupt-Exports und Funktionen |
| cf_logs.lua | Logging-Konfiguration |
| cf_holster.lua | Holster-System-Einstellungen |
| cf_vehicledamage.lua | Fahrzeugschaden-Einstellungen |

### 🔗 Webhook-Konfiguration

Die Datei \`webhooks.lua\` enthält Platzhalter für Discord-Webhooks:
\`\`\`lua
Config_Sperrzone.Webhook = "WEBHOOK_HERE"
\`\`\`
> ⚠️ Ersetze "WEBHOOK_HERE" mit deinem Discord-Webhook-Link

## 📚 Abhängigkeiten

- **ESX Framework** - Grundlegendes Framework
- **MySQL-Async** - Datenbankverbindung
- **FiveM-Map-Skript** - Für Minimap-Funktionalität

## 📞 Support

Bei Fragen oder Problemen wende dich bitte an den Support-Discord.

---

<div align="center">
  <p>Mit ❤️ entwickelt für die FiveM-Community</p>
  <p>© 2023 Sanchez-Base. Alle Rechte vorbehalten.</p>
</div>
