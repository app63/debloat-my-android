# Android Debloater (Deutsch)

Dieses Repository bietet eine spezialisierte Skill für KI-Agenten (wie OpenCode und Claude), um Bloatware von Android-Telefonen und -Tablets mittels ADB (Android Debug Bridge) zu entfernen. Es entfernt unnötige vorinstallierte Apps, einschließlich Google-Apps und markenspezifischer Apps, während sichergestellt wird, dass das Gerät funktionsfähig bleibt.

## 🤖 Anweisungen für den Agenten

Wenn dieses Repository als Skill geladen wird, sollte der Agent:
1. **ADB überprüfen**: Prüfen, ob `adb` in der Umgebung verfügbar ist.
2. **Gerät verbinden**: `./tools/debloat.sh` mit der angegebenen Geräte-ID oder IP verwenden.
3. **Sicherheitscheck**: Den Benutzer informieren, dass der Google Play Store und der aktive Launcher geschützt sind und nicht entfernt werden.
4. **Ausführung**: Das Debloat-Skript ausführen und das Ergebnis melden.

## 🚀 Funktionen

- **Umfassende Entfernung**: Ziel sind alle installierten Pakete, außer kritischen Systemkomponenten.
- **Sicherheit Zuerst**: 
  - **Schützt Google Play Store**: Stellt sicher, dass Apps weiterhin installiert und aktualisiert werden können.
  - **Schützt Standard-Launcher**: Erkennt dynamisch den aktiven Launcher und schützt ihn, um ein "Bricken" des Geräts zu verhindern.
- **Fallback-Mechanismus**: Wenn ein Paket nicht vollständig deinstalliert werden kann, versucht das Tool, es zu deaktivieren.
- **ADB-Integration**: Funktioniert über USB oder WLAN.

## 🛠️ Voraussetzungen

1. **ADB installiert**: Stellen Sie sicher, dass `adb` auf Ihrem Computer installiert ist.
2. **USB-Debugging aktiviert**: 
   - Gehen zu `Einstellungen` $\rightarrow$ `Über das Telefon` $\rightarrow$ 7-mal auf `Build-Nummer` tippen.
   - Gehen zu `Einstellungen` $\rightarrow$ `System` $\rightarrow$ `Entwickleroptionen` $\rightarrow$ `USB-Debugging` aktivieren.
3. **Gerät verbunden**: Verbinden Sie Ihr Telefon per USB oder WLAN mit Ihrem Computer.

## 📖 Nutzung

### Für KI-Agenten
Der Agent kann einfach ausführen:
```bash
chmod +x tools/debloat.sh
./tools/debloat.sh [geräte_id/ip]
```

### Manuelle Nutzung
Wenn Sie dies manuell ausführen:
```bash
chmod +x tools/debloat.sh
./tools/debloat.sh <ihre_geräte_id_oder_ip>
```

### Apps wiederherstellen
Wenn Sie versehentlich etwas Wichtiges entfernt haben, können Sie es mit dem folgenden ADB-Befehl wieder installieren:
```bash
adb shell cmd package install-existing <paketname>
```

## 📂 Projektstruktur

- `tools/`: Enthält die Hauptskripte für Debloating und Wiederherstellung.
  - `debloat.sh`: Das Hauptskript zum Entfernen von Bloatware.
  - `restore.sh`: Hilfsskript für die Wiederherstellungsanleitung.
- `AGENTS.md`: Spezifische Anweisungen für KI-Agenten, die in diesem Repo arbeiten.

## ⚠️ Haftungsausschluss

**Nutzen Sie dieses Tool auf eigene Gefahr.** Obwohl wir Vorkehrungen treffen, um den Launcher und den Play Store zu schützen, kann das Entfernen von System-Apps manchmal zu unerwartetem Verhalten führen. Stellen Sie immer sicher, dass Sie ein Backup Ihrer wichtigen Daten haben.
