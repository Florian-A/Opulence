#! /bin/bash

prompt_message()
{
  # Notification (bleu).
  if [ $1 = 0 ]
  then
  {
    echo -e "\e[2m"$(date +"%m-%d-%Y %T")"\e[22m" "\e[104m[$LOCAL_NOTIFICATION]:" "${2^}" "\e[49m";
  }
  # Attention (orange).
  elif [ $1 = 1 ]
  then
  {
    echo -e "\e[2m"$(date +"%m-%d-%Y %T")"\e[22m" "\e[43m[$LOCAL_WARNING]:" "${2^}" "\e[49m";
  }
  # Erreur (rouge).
  elif [ $1 = 2 ]
  then
  {
    echo -e "\e[2m"$(date +"%m-%d-%Y %T")"\e[22m" "\e[41m[$LOCAL_ERROR]:" "${2^}" "\e[49m";
  }
  # Information (vert).
  elif [ $1 = 3 ]
  then
  {
    echo -e "\e[2m"$(date +"%m-%d-%Y %T")"\e[22m" "\e[42m[$LOCAL_INFORMATION]:" "${2^}" "\e[49m";
  }
  # Test
  elif [ $1 = 4 ]
  then
  {
    message=${2^};
    strlen=${#message};
    strlen=$((strlen));
    delimiter="";
    i=0;

    if [ $strlen -gt 70 ]
    then

      delimiter+=" \e[48;5;226m                                                                     ";

    else
      while [ $i -lt $strlen ]
      do
        delimiter+=" ";
        i=`expr $i + 1`;
      done
    fi

    delimiter+="       \e[49m ";

    echo -e "";
    echo -e "${delimiter//" "/" "}";

    processing=$message;

    p=0;

    while [ "$processing" != "" ]
    do
      tmp_message=" \e[31;48;5;226m   ${message:$(($p*70)):70}";

      if [ $((70-${#processing})) -ne 70 ] && [ $((70-${#processing})) -gt 0  ]
      then

        if [ $strlen -ge 70 ]
        then

          x=0;
          while [ $x -lt $((70-${#processing})) ]
          do
            tmp_message+=" ";
            x=`expr $x + 1`;
          done

        fi

        tmp_message+="   \e[49m ";

      else
        tmp_message+="   \e[49m ";
      fi

      processing=${message:$(($(($p+1))*70)):70};
      echo -e "${tmp_message//" "/" "}"

      p=`expr $p + 1`;

    done

    echo -e "${delimiter//" "/" "}";
    echo -e "";

  }
  fi

  tput sgr0;
}
