#! /bin/bash
this_directory=$(dirname $0)"/../";

# Importation de la localisation.
. $this_directory/bash/localization.lib.bash;

# Importation des scripts d'affichage des messages dans la console.
. $this_directory/bash/prompt_message.lib.bash;

# Importation des scripts pour la gestion de Xterm.
. $this_directory/bash/xterm.lib.bash;

# Importation des scripts pour la gestion par-feu iptables.
. $this_directory/bash/firewall.lib.bash

# Importation des scripts gestion du réseau 3G / 4G / LTE.
. $this_directory/bash/mobile_broadband.lib.bash;

# Importation des scripts gestion du navigateur web.
. $this_directory/bash/navigator.lib.bash;


CONF_URL=$(grep "CONF_URL=" $this_directory/config.cfg | cut -f2 -d"=");
CONF_WAN_ENABLED=$(grep "CONF_WAN_ENABLED=" $this_directory/config.cfg | cut -f2 -d"=");
CONF_WAN_IP=$(grep "CONF_WAN_IP=" $this_directory/config.cfg | cut -f2 -d"=");
CONF_INTERFACE_NAME=$(grep "CONF_INTERFACE_NAME=" $this_directory/config.cfg | cut -f2 -d"=");
CONF_SUDO_FNC=$(grep "CONF_SUDO_FNC=" $this_directory/config.cfg | cut -f2 -d"=");
CONF_ROOT_PWD=$(grep "CONF_ROOT_PWD=" $this_directory/config.cfg | cut -f2 -d"=");
CONF_WAN_WAITTIME=$(grep "CONF_WAN_WAITTIME=" $this_directory/config.cfg | cut -f2 -d"=");
CONF_WINDOW_NAME=$(grep "CONF_WINDOW_NAME=" $this_directory/config.cfg | cut -f2 -d"=");
CONF_WINDOW_SIZE_AND_POSITION=$(grep "CONF_WINDOW_SIZE_AND_POSITION=" $this_directory/config.cfg | cut -f2 -d"=");

# Fonction de démarrage du modem.
wan()
{
	if [ $CONF_SUDO_FNC == "yes" ]
	then
		if [ $(echo "$CONF_ROOT_PWD" | sudo -S uptime 2>&1|grep "load" |wc -l) -eq 0 ]
		then
		  prompt_message 4 "$LOCAL_WAN";
		fi
	fi

	if [ $CONF_SUDO_FNC == "yes" ]
	then
		if [ $(sudo uptime 2>&1|grep "load" |wc -l) -eq 0 ]
		then
		  prompt_message 2 "$LOCAL_AUTH_FAILED";
		  sleep 3;
		  exit;
		fi
	fi

  clear;
  config_modem;
  change_ip;
  sleep 1;
}

# Fonction de changement de l'adresse IP
xterm_change_ip()
{
  xterm_terminal "$this_directory/bash/start.bash wan_change_ip";
}

wan_change_ip()
{
  change_ip;
  sleep 4;
}

firewall()
{
	if [ $CONF_SUDO_FNC == "yes" ]
	then
		if [ $(echo "$CONF_ROOT_PWD" | sudo -S uptime 2>&1|grep "load" |wc -l) -eq 0 ]
		then
		  prompt_message 4 "$LOCAL_FIREWALL";
		fi

		if [ $(sudo uptime 2>&1|grep "load" |wc -l) -eq 0 ]
		then
		  prompt_message 2 "$LOCAL_AUTH_FAILED";
		  sleep 3;
		  exit;
		fi
		clear;
		config_iptables $CONF_INTERFACE_NAME;
	fi
}

move_and_resize()
{
  if [ "$CONF_WINDOW_NAME" ] || [ "$CONF_WINDOW_SIZE_AND_POSITION" ]
  then
        sleep 1;
	wmctrl -r chromium -e $CONF_WINDOW_SIZE_AND_POSITION;
  fi
}

# Fonction principal par défaut.
start()
{
  if [ "$CONF_INTERFACE_NAME" ]
  then

    xterm_terminal "$this_directory/bash/start.bash firewall;";
  fi

  if [ "$CONF_WAN_ENABLED" == "yes" ]
  then
		if [[ $CONF_WAN_IP =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]
		then
			xterm_terminal $this_directory/bash/start.bash wan;
		fi
  fi
  
  if [ "$1" ]
  then
    move_and_resize & start_navigator $1 $2;
  else
    move_and_resize & start_navigator $CONF_URL $2;
  fi
}

# Commutateur principal qui redirige vers la bonne fonction.
case $1 in
    "wan" )
        wan ;;
    "firewall" )
        firewall ;;
    "wan_change_ip" )
        wan_change_ip ;;
    "xterm_change_ip" )
        xterm_change_ip ;;
    * )
        start $1 $2;;
esac
