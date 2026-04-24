# NoitaQuickSave 🧙‍♂️🧪

**AutoHotkey v2** Noita save management. This tool leverages Windows **Robocopy** to ensure maximum speed, data integrity, and organized version history.

## Key Features

* **F5 (Safe Backup):** Automatically triggers `Alt+F4` to force Noita to commit world chunks to disk, creates a timestamped backup, and restarts the game immediately.
* **F9 (Quick Restore):** Opens a GUI with your save history. Backups are automatically sorted by **newest first**.
* **Dynamic Path Discovery:** Automatically detects your Noita installation path while the game is running.

## Installation

1. Install [AutoHotkey v2](https://www.autohotkey.com/v2/).
2. Download `NoitaQuickSave.ahk`.
3. Run the script.

## Usage

* **F5:** Save current progress. The game will close, backup, and relaunch.
* **F9:** Open the Restore Menu. Double-click a save or select one and press "Load" to restore and relaunch.

**Save Location:**
Backups are stored in:  
`%AppData%\..\LocalLow\Nolla_Games_Noita\my_history_saves`
