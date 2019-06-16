#! /bin/bash

start_navigator()
{
  if [ "$2" ]
  then
    random_nb=$(echo "$2" | md5sum | tr abcdefghij 0123456789 | cut -c1-2);
    random_nb=$((10#$random_nb));
    while [ "$random_nb" -gt 18 ]
    do
	random_nb=$((random_nb - 19));
    done
    random_nb=$((random_nb + 1));

  else
    random_nb=$(shuf -i 1-19 -n 1);
  fi
  user_agent=$(sed -n "$random_nb"p $this_directory/bank/user_agent);
  platform=$(sed -n "$random_nb"p $this_directory/bank/platform);

  if [ "$2" ]
  then
    max_touchpoints=$(echo "$2" | md5sum | tr abcdefghij 0123456789 | cut -c3-3);
    max_touchpoints=$((10#$max_touchpoints));
    while [ "$max_touchpoints" -gt 10 ]
    do
	max_touchpoints=$((max_touchpoints - 9));
    done
    max_touchpoints=$(($max_touchpoints+1));
  else
    max_touchpoints=$(shuf -i 0-10 -n 1);
  fi

  if [ "$2" ]
  then
    random_nb=$(echo "$2" | md5sum | tr abcdefghij 0123456789 | cut -c4-4);
    random_nb=$((10#$random_nb));
    while [ "$random_nb" -gt 10 ]
    do
	random_nb=$((random_nb - 9));
    done
    random_nb=$(($random_nb+1));
  else
    random_nb=$(shuf -i 0-10 -n 1);
  fi
  height=$(sed -n "$random_nb"p $this_directory/bank/height);
  width=$(sed -n "$random_nb"p $this_directory/bank/width);

  if [ "$2" ]
  then
    random_nb=$(echo "$2" | md5sum | tr abcdefghij 0123456789 | cut -c4-4);
    random_nb=$((10#$random_nb));
    while [ "$random_nb" -gt 10 ]
    do
	random_nb=$((random_nb - 9));
    done
    random_nb=$(($random_nb+1));
  else
    random_nb=$(shuf -i 0-10 -n 1);
  fi

  if [ "$2" ]
  then
    language=$(echo "$2" | md5sum | tr abcdefghij 0123456789 | cut -c5-5);
    language=$((10#$language));
    while [ "$language" -gt 1 ]
    do
	language=$((language - 2));
    done
  else
    language=$(shuf -i 1-2 -n 1);
  fi
  case $language in
     1) language="fr";;
     *) language="en";;
  esac

  if [ "$2" ]
  then
    do_nottrack=$(echo "$2" | md5sum | tr abcdefghij 0123456789 | cut -c6-6);
    do_nottrack=$((10#$do_nottrack));
    while [ "$do_nottrack" -gt 1 ]
    do
	do_nottrack=$((do_nottrack - 2));
    done
  else
    do_nottrack=$(shuf -i 1-2 -n 1);
  fi
  case $do_nottrack in
     1) do_nottrack=1;;
     *) do_nottrack=0;;
  esac

  if [ "$2" ]
  then
    color_depth=$(echo "$2" | md5sum | tr abcdefghij 0123456789 | cut -c7-7);
    color_depth=$((10#$color_depth));
    while [ "$color_depth" -gt 1 ]
    do
	color_depth=$((color_depth - 4));
    done
  else
    color_depth=$(shuf -i 1-4 -n 1);
  fi
  case $color_depth in
     1) color_depth=16;;
     2) color_depth=24;;
     3) color_depth=32;;
     *) color_depth=48;;
  esac

  if [ "$2" ]
  then
      cpu_class="$(echo "$2" | md5sum | tr abcdefghij 0123456789 | cut -c8-13)";
  else
      cpu_class="$(shuf -i 0-32000 -n 1)";
  fi



  if [ "$2" ]
  then
    tar xzvf $this_directory/gz/user_data.tar.gz  -C $this_directory/tmp/ --transform 's/user_data/'$(echo "$2" | md5sum | tr abcdefghij 0123456789 | cut -c1-30)'/'  2>> $this_directory/logs/errors.log;
    sed -i -e "
    s/PLATFORM/$platform/g;
    s/LANGUAGE/$language/g;
    s/HEIGHT/$height/g;
    s/WIDTH/$width/g;
    s/TOUCHPOINTS/$max_touchpoints/g;
    s/DONOTTRACK/$do_nottrack/g;
    s/COLORDEPTH/$color_depth/g;
    s/CPUCLASS/$cpu_class/g;
    " $this_directory/tmp/$(echo "$2" | md5sum | tr abcdefghij 0123456789 | cut -c1-30)/Default/Extensions/nfpmpeknhaelkljibgnkdneollleaifb/1.0_0/main.js;
    chromium --user-agent="$user_agent" --user-data-dir=$this_directory/tmp/$(echo "$2" | md5sum | tr abcdefghij 0123456789 | cut -c1-30)/ $1 2>> $this_directory/logs/errors.log;
  else
    rm -R $this_directory/tmp/user_data  > /dev/null 2>> $this_directory/logs/errors.log;
    tar xzvf $this_directory/gz/user_data.tar.gz  -C $this_directory/tmp/  2>> $this_directory/logs/errors.log;
    sed -i -e "
    s/PLATFORM/$platform/g;
    s/LANGUAGE/$language/g;
    s/HEIGHT/$height/g;
    s/WIDTH/$width/g;
    s/TOUCHPOINTS/$max_touchpoints/g;
    s/DONOTTRACK/$do_nottrack/g;
    s/COLORDEPTH/$color_depth/g;
    s/CPUCLASS/$cpu_class/g;
    " $this_directory/tmp/user_data/Default/Extensions/nfpmpeknhaelkljibgnkdneollleaifb/1.0_0/main.js;
    chromium --user-agent="$user_agent" --user-data-dir=$this_directory/tmp/user_data/ $1 2>> $this_directory/logs/errors.log;
  fi

}
