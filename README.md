# 🎮 Sanchez-Base

<div align="center">
  <h3>A comprehensive FiveM resource for enhanced gameplay mechanics</h3>
  <p>Developed for optimal server performance and player experience</p>
</div>

---

## 📋 Table of Contents
- [Main Features](#-main-features)
- [Commands](#-commands)
- [Script Functions](#-script-functions)
- [Installation](#-installation)
- [Configuration](#-configuration)
- [Dependencies](#-dependencies)
- [Support](#-support)

## 🚀 Main Features

### 🛡️ Anti-Cheat & Security
- **Anti-Troll System** - Protects players from trolling
- **Combat-Log Protection** - Prevents combat logging
- **Anti-VDM System** - Stops vehicle deathmatch
- **Mod Menu Detection** - Detects and prevents cheating

### 👥 Player Features
- **Knockout System** - Realistic K.O. system
- **Carry System** - Player carrying/transport
- **Sit System** - Enhanced sitting options
- **Holster System** - Realistic weapon holster
- **GPS System** - Advanced navigation
- **Plastic Surgery** - Character customization
- **Tattoo System** - Comprehensive tattoo system
- **Backpack System** - Extended inventory for donors

### 🚗 Vehicle Systems
- **Legacy Fuel** - Realistic fuel system
- **Vehicle Lock** - Security system
- **Vehicle Damage** - Detailed damage models
- **Speed Limiter** - Speed control
- **ELS** - Enhanced Lighting System

### 💰 Economy Features
- **Billing System** - Digital payments
- **Mini-job System** - Additional earning opportunities
- **Scrapyard** - Vehicle recycling
- **Shell Collection** - Collection activity

### 🌍 Security Zones
- **Safezone System** - Protected areas
- **Restricted Zones** - Access restrictions
- **Faction Locks** - Faction-based controls

## ⌨️ Commands

### 📝 General Commands
\`\`\`
/plz         - Shows current postal code
/sit         - Sit down
/carry       - Carry player
/gps         - Open GPS system
/knockout    - Knock out player
/billing     - Create bill
\`\`\`

### 🚙 Vehicle Commands
\`\`\`
/carlock     - Lock/unlock vehicle
/shuff       - Switch to driver's seat
/repair      - Repair vehicle
/speedlimiter- Speed limiter
\`\`\`

### 👑 Admin Commands
\`\`\`
/clip       - Noclip through walls (Admin)
/sperrzone  - Create/remove restricted zone
/troll      - Anti-troll measures
\`\`\`

## 🔧 Script Functions

### 💻 Client Exports
\`\`\`lua
-- Vehicle Functions
exports['Sanchez-Base']:GetFuel(vehicle)
exports['Sanchez-Base']:SetFuel(vehicle, fuel)
exports['Sanchez-Base']:LockVehicle(vehicle)
exports['Sanchez-Base']:UnlockVehicle(vehicle)

-- Player Functions
exports['Sanchez-Base']:IsPlayerInSafezone()
exports['Sanchez-Base']:CanPlayerPvP()
exports['Sanchez-Base']:IsPlayerKnockedOut()

-- GPS Functions
exports['Sanchez-Base']:SetGPSRoute(coords)
exports['Sanchez-Base']:ClearGPSRoute()
\`\`\`

### 🖥️ Server Exports
\`\`\`lua
-- Economy Functions
exports['Sanchez-Base']:CreateBill(playerId, amount, reason)
exports['Sanchez-Base']:AddMoney(playerId, amount)

-- Management Functions
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

1. Copy the folder to your FiveM resources directory
2. Add the following line to your \`server.cfg\`:
\`\`\`cfg
ensure Sanchez-Base
\`\`\`

## ⚙️ Configuration

Configuration files are located in the \`config/\` directory:

| File | Description |
|-------|-------------|
| cf_exports.lua | Main exports and functions |
| cf_logs.lua | Logging configuration |
| cf_holster.lua | Holster system settings |
| cf_vehicledamage.lua | Vehicle damage settings |

### 🔗 Webhook Configuration

The \`webhooks.lua\` file contains placeholders for Discord webhooks:
\`\`\`lua
Config_Sperrzone.Webhook = "WEBHOOK_HERE"
\`\`\`
> ⚠️ Replace "WEBHOOK_HERE" with your Discord webhook link

## 📚 Dependencies

- **ESX Framework** - Core framework
- **MySQL-Async** - Database connection
- **FiveM Map Script** - For minimap functionality

## 📞 Support

For questions or issues, please contact our Support Discord.

---

<div align="center">
  <p>Developed with ❤️ for the FiveM Community</p>
  <p>© 2023 Sanchez-Base. All rights reserved.</p>
</div>
