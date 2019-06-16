#! /bin/bash

# Réglage de la langue suivant les préférances de l'utilisateur.

CONFIG_LANG="${LANG:0:2}";

if [ $(ls $this_directory/localization/"$CONFIG_LANG" 2> /dev/null) ]
then
  LOCAL_NOTIFICATION=$(grep "LOCAL_NOTIFICATION=" $this_directory/localization/"$CONFIG_LANG" | cut -f2 -d"=");
  LOCAL_WARNING=$(grep "LOCAL_WARNING=" $this_directory/localization/"$CONFIG_LANG" | cut -f2 -d"=");
  LOCAL_ERROR=$(grep "LOCAL_ERROR=" $this_directory/localization/"$CONFIG_LANG" | cut -f2 -d"=");
  LOCAL_INFORMATION=$(grep "LOCAL_INFORMATION=" $this_directory/localization/"$CONFIG_LANG" | cut -f2 -d"=");
  LOCAL_CHROMIUM=$(grep "LOCAL_CHROMIUM=" $this_directory/localization/"$CONFIG_LANG" | cut -f2 -d"=");
  LOCAL_WAN=$(grep "LOCAL_WAN=" $this_directory/localization/"$CONFIG_LANG" | cut -f2 -d"=");
  LOCAL_FIREWALL=$(grep "LOCAL_FIREWALL=" $this_directory/localization/"$CONFIG_LANG" | cut -f2 -d"=");
  LOCAL_WAN_CONFIG=$(grep "LOCAL_WAN_CONFIG=" $this_directory/localization/"$CONFIG_LANG" | cut -f2 -d"=");
  LOCAL_WAN_NO_CON=$(grep "LOCAL_WAN_NO_CON=" $this_directory/localization/"$CONFIG_LANG" | cut -f2 -d"=");
  LOCAL_WAN_CHAN_IP=$(grep "LOCAL_WAN_CHAN_IP=" $this_directory/localization/"$CONFIG_LANG" | cut -f2 -d"=");
  LOCAL_WAN_SUCCESS=$(grep "LOCAL_WAN_SUCCESS=" $this_directory/localization/"$CONFIG_LANG" | cut -f2 -d"=");
  LOCAL_WAN_CHAN_IP_ERROR=$(grep "LOCAL_WAN_CHAN_IP_ERROR=" $this_directory/localization/"$CONFIG_LANG" | cut -f2 -d"=");
  LOCAL_WAN_CHAN_IP_SUCCESS=$(grep "LOCAL_WAN_CHAN_IP_SUCCESS=" $this_directory/localization/"$CONFIG_LANG" | cut -f2 -d"=");
  LOCAL_FIREWALL_CONFIG=$(grep "LOCAL_FIREWALL_CONFIG=" $this_directory/localization/"$CONFIG_LANG" | cut -f2 -d"=");
  LOCAL_FIREWALL_SUCCESS=$(grep "LOCAL_FIREWALL_SUCCESS=" $this_directory/localization/"$CONFIG_LANG" | cut -f2 -d"=");
  LOCAL_AUTH_FAILED=$(grep "LOCAL_AUTH_FAILED=" $this_directory/localization/"$CONFIG_LANG" | cut -f2 -d"=");
else
  LOCAL_NOTIFICATION=$(grep "LOCAL_NOTIFICATION=" $this_directory/localization/en | cut -f2 -d"=");
  LOCAL_WARNING=$(grep "LOCAL_WARNING=" $this_directory/localization/en | cut -f2 -d"=");
  LOCAL_ERROR=$(grep "LOCAL_ERROR=" $this_directory/localization/en | cut -f2 -d"=");
  LOCAL_INFORMATION=$(grep "LOCAL_INFORMATION=" $this_directory/localization/en | cut -f2 -d"=");
  LOCAL_CHROMIUM=$(grep "LOCAL_CHROMIUM=" $this_directory/localization/en | cut -f2 -d"=");
  LOCAL_WAN=$(grep "LOCAL_WAN=" $this_directory/localization/en | cut -f2 -d"=");
  LOCAL_FIREWALL=$(grep "LOCAL_FIREWALL=" $this_directory/localization/en | cut -f2 -d"=");
  LOCAL_WAN_CONFIG=$(grep "LOCAL_WAN_CONFIG=" $this_directory/localization/en | cut -f2 -d"=");
  LOCAL_WAN_NO_CON=$(grep "LOCAL_WAN_NO_CON=" $this_directory/localization/en | cut -f2 -d"=");
  LOCAL_WAN_CHAN_IP=$(grep "LOCAL_WAN_CHAN_IP=" $this_directory/localization/en | cut -f2 -d"=");
  LOCAL_WAN_SUCCESS=$(grep "LOCAL_WAN_SUCCESS=" $this_directory/localization/en | cut -f2 -d"=");
  LOCAL_WAN_CHAN_IP_ERROR=$(grep "LOCAL_WAN_CHAN_IP_ERROR=" $this_directory/localization/en | cut -f2 -d"=");
  LOCAL_WAN_CHAN_IP_SUCCESS=$(grep "LOCAL_WAN_CHAN_IP_SUCCESS=" $this_directory/localization/en | cut -f2 -d"=");
  LOCAL_FIREWALL_CONFIG=$(grep "LOCAL_FIREWALL_CONFIG=" $this_directory/localization/en | cut -f2 -d"=");
  LOCAL_FIREWALL_SUCCESS=$(grep "LOCAL_FIREWALL_SUCCESS=" $this_directory/localization/en | cut -f2 -d"=");
  LOCAL_AUTH_FAILED=$(grep "LOCAL_AUTH_FAILED=" $this_directory/localization/en | cut -f2 -d"=");
fi
