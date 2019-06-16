#! /bin/bash

config_iptables()
{
  sudo iptables -I OUTPUT -o $1 -p tcp --destination-port 80 -j DROP
  prompt_message 0 "$LOCAL_FIREWALL_CONFIG";
  sudo iptables -I OUTPUT -o $1 -p tcp --destination-port 443 -j DROP
  sudo ip6tables -I OUTPUT -o $1 -p tcp --destination-port 80 -j DROP
  sudo ip6tables -I OUTPUT -o $1 -p tcp --destination-port 443 -j DROP
  sudo ip6tables -I OUTPUT -o $1 -p udp --destination-port 443 -j DROP
  prompt_message 3 "$LOCAL_FIREWALL_SUCCESS";
}
