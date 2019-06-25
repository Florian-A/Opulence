# Opulence
Opulence est une petite suite de scripts Bash dont le but est de faciliter l'anonymisation de la navigation.

### Fonctionnement
Opulence est basé sur deux petites choses.

- La première, est une modification de l'identité du navigateur (après modification de l'objet [Navigator](https://developer.mozilla.org/en-US/docs/Web/API/Navigator "Navigator"))
- La deuxième, par un changement d'adresse IPv4 en forçant un modem 3G/4G à se déconnecter puis à rapidement à se reconnecter à son antenne-relais.

### Prérequis
Doit être installé sur le système (idéalement un Debian 9 ou plus), les programmes suivants :
- Bash
- Chromium
- Xterm
- Iptables (optionnel) 
- Wmctrl (optionnel)

**Pour utiliser les fonctionnalités 3G/4G qui permettent de changer rapidement d'adresse IPv4 vous devez vous munir d'un modem ou routeur configurable par des requêtes cURL.**

La plupart des modems et routeurs Huawei 4G le sont. 
Opulence a été développé pour un [Huawei E3372](https://consumer.huawei.com/en/mobile-broadband/e3372/specs/ "Huawei E3372").

### Configuration
Editez le fichier "config.cfg" pour modifier les paramètres suivants :
+ L'adresse URL par défaut.
+ Activation de la connexion 4G LTE.
+ Adresse IPv4 du modem 4G LTE.
+ Temps d'attente après le "sabotage" de la connexion 4G LTE.
+ Taille et position de Chromium à son lancement.
+ Activation des fonctionnalitées demandant un accès super-utilisateur.
+ Mot de passe du super-administrateur.
+ Nom de l'interface réseau dont il faut appliquer des règles de coupe-feu.

### Utilisation
Sur certains environnements graphiques, il est possible de lancer Opulence par un double-clic sur le fichier "run.desktop" ou la commande suivante :

`bash -c '"$(dirname "$1")"/bash/start.bash'`

Pour changer rapidement d'adresse IP, double-clic sur "changeip.desktop" ou la commande suivante :

`bash -c '"$(dirname "$1")"/bash/start.bash xterm_change_ip'`
