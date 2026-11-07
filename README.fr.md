# Android Debloater (Français)

Ce dépôt fournit une compétence spécialisée pour les agents d'IA (comme OpenCode et Claude) afin de supprimer les bloatwares des téléphones et tablettes Android via ADB (Android Debug Bridge). Il supprime les applications préinstallées inutiles, y compris les applications Google et les applications spécifiques aux marques, tout en s'assurant que l'appareil reste fonctionnel.

## 🤖 Instructions pour l'Agent

Lorsque ce dépôt est chargé comme une compétence, l'agent doit :
1. **Vérifier ADB** : Vérifier si `adb` est disponible dans l'environnement.
2. **Connecter l'Appareil** : Utiliser `./tools/debloat.sh` avec l'ID de l'appareil ou l'IP fournis.
3. **Vérification de Sécurité** : Informer l'utilisateur que le Google Play Store et le Launcher actif sont protégés et ne seront pas supprimés.
4. **Exécution** : Exécuter le script de debloat et rapporter le résultat.

## 🚀 Fonctionnalités

- **Suppression Complète** : Cible tous les paquets installés, sauf les composants critiques du système.
- **La Sécurité d'Abord** : 
  - **Protège le Google Play Store** : Garantit que vous pouvez toujours installer et mettre à jour des applications.
  - **Protège le Launcher par Défaut** : Détecte dynamiquement et protège le launcher actif pour éviter de briquer l'appareil.
- **Mécanisme de Repli** : Si un paquet ne peut pas être complètement désinstallé, l'outil tente de le désactiver.
- **Intégration ADB** : Fonctionne via USB ou Wi-Fi.

## 🛠️ Prérequis

1. **ADB Installé** : Assurez-vous d'avoir `adb` installé sur votre ordinateur.
2. **Débogage USB Activé** : 
   - Allez dans `Paramètres` $\rightarrow$ `À propos du téléphone` $\rightarrow$ Appuyez 7 fois sur `Numéro de build`.
   - Allez dans `Paramètres` $\rightarrow$ `Système` $\rightarrow$ `Options pour les développeurs` $\rightarrow$ Activez le `Débogage USB`.
3. **Appareil Connecté** : Connectez votre téléphone à votre ordinateur via USB ou Wi-Fi.

## 📖 Utilisation

### Pour les Agents d'IA
L'agent peut simplement exécuter :
```bash
chmod +x tools/debloat.sh
./tools/debloat.sh [id_appareil/ip]
```

### Utilisation Manuelle
Si vous l'utilisez manuellement :
```bash
chmod +x tools/debloat.sh
./tools/debloat.sh <votre_id_ou_ip_appareil>
```

### Restaurer des applications
Si vous avez accidentellement supprimé quelque chose d'important, vous pouvez le réinstaller en utilisant la commande ADB suivante :
```bash
adb shell cmd package install-existing <nom_du_paquet>
```

## 📂 Structure du Projet

- `tools/`: Contient les scripts principaux de debloat et de restauration.
  - `debloat.sh`: Le script principal pour supprimer les bloatwares.
  - `restore.sh`: Script utilitaire pour le guide de restauration.
- `AGENTS.md`: Conseils spécifiques pour les agents d'IA travaillant dans ce dépôt.

## ⚠️ Avertissement

**Utilisez cet outil à vos propres risques.** Bien que nous prenions des précautions pour protéger le launcher et le Play Store, la suppression d'applications système peut parfois entraîner des comportements inattendus. Assurez-vous toujours d'avoir une sauvegarde de vos données importantes.
