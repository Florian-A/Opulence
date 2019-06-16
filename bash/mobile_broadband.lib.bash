#! /bin/bash

# Détection et configuration du modem USB 3G/4G LTE.
config_modem()
{
  if [ $CONF_SUDO_FNC == "yes" ]
  then
	  prompt_message 0 "$LOCAL_WAN_CONFIG";
	  # Déchargement du driver stockage de masse en USB.
	  o=0;
	  while [ $o -lt 10 ]
	  do
	    sudo eject /dev/sd$(printf "\\$(printf '%03o' "$(($o+97))")")  > /dev/null 2>&1;
	    if [  ! -z  "$(sudo rmmod usb-storage 2>&1 | grep 'is not currently loaded')" ]
	    then
	      o=100;
	    fi
	    sleep 0.5;
	    o=`expr $o + 1`;
	  done
  fi

  # Test si la clé 4G est prête a travailler.
  rr=0;
  while [ $rr -lt 100 ]
  do
    sleep 1;
    ping -c3 "$CONF_WAN_IP"  > /dev/null 2>&1;
    ping_response_config=$?;

    if [ $ping_response_config -ne 0 ]
        then
            prompt_message 1 "$LOCAL_WAN_NO_CON";
        else
            rr=101;
    fi
    rr=`expr $rr + 1`;
  done

  # Configuration de la clé 4G pour toutes bandes de fréquences.
  Ses=$(curl -s http://"$CONF_WAN_IP"/api/webserver/SesTokInfo | tr -d '\r\n');
  SesToken=$(echo $Ses | sed 's/^.*<SesInfo>//' | sed 's/<\/SesInfo>.*//');
  TokenInfo=$(echo $Ses | sed 's/^.*<TokInfo>//' | sed 's/<\/TokInfo>.*//');
  curl -s 'http://'"$CONF_WAN_IP"'/api/net/net-mode' -H 'Cookie: '$SesToken  -H '__RequestVerificationToken: '$TokenInfo --data '<?xml version="1.0" encoding="UTF-8"?><request><NetworkMode>00</NetworkMode><NetworkBand>3FFFFFFF</NetworkBand><LTEBand>7FFFFFFFFFFFFFFF</LTEBand></request>' --compressed > /dev/null 2>&1;

}

start_modem()
{
  # Arrêt des autres connexions.
  o=0;
  while [ $o -lt 10 ]
  do
    sudo ip link set wlan$o down > /dev/null 2>&1;
    sleep 0.1;
    o=`expr $o + 1`;
  done

  # Démarrage du modem.

}

change_ip()
{

  prompt_message 0 "$LOCAL_WAN_CHAN_IP";

  # Enregistrement de l'IP actuelle.
  currentIP=$(curl -s 'https://api.ipify.org');

  # Sabotage de la connexion pour changement d'IP.
  Ses=$(curl -s http://"$CONF_WAN_IP"/api/webserver/SesTokInfo | tr -d '\r\n');
  SesToken=$(echo $Ses | sed 's/^.*<SesInfo>//' | sed 's/<\/SesInfo>.*//');
  TokenInfo=$(echo $Ses | sed 's/^.*<TokInfo>//' | sed 's/<\/TokInfo>.*//');
  curl -s 'http://'"$CONF_WAN_IP"'/api/net/net-mode' -H 'Cookie: '$SesToken  -H '__RequestVerificationToken: '$TokenInfo --data '<?xml version:"1.0" encoding="UTF-8"?><request><NetworkMode>03</NetworkMode><NetworkBand>0</NetworkBand><LTEBand>80</LTEBand></request>' --compressed > /dev/null 2>&1;

  sleep "$CONF_WAN_WAITTIME";

  # Remise en état normal de la connexion.
  Ses=$(curl -s http://"$CONF_WAN_IP"/api/webserver/SesTokInfo | tr -d '\r\n');
  SesToken=$(echo $Ses | sed 's/^.*<SesInfo>//' | sed 's/<\/SesInfo>.*//');
  TokenInfo=$(echo $Ses | sed 's/^.*<TokInfo>//' | sed 's/<\/TokInfo>.*//');
  curl -s 'http://'"$CONF_WAN_IP"'/api/net/net-mode' -H 'Cookie: '$SesToken  -H '__RequestVerificationToken: '$TokenInfo --data '<?xml version="1.0" encoding="UTF-8"?><request><NetworkMode>00</NetworkMode><NetworkBand>3FFFFFFF</NetworkBand><LTEBand>7FFFFFFFFFFFFFFF</LTEBand></request>' --compressed > /dev/null 2>&1;


  #Test si la nouvelle IP est différente.

  newIP=$(curl -s 'https://api.ipify.org');

  if [ $currentIP = $newIP ]
  then
	prompt_message 1 "$LOCAL_WAN_CHAN_IP_ERROR";
	sleep 5;
	exit;
  else
	prompt_message 3 "$LOCAL_WAN_CHAN_IP_SUCCESS$newIP"
  fi

}

stop_modem()
{
  # Arrêt du modem.
  prompt_message 2 "Stoping network !"
}
