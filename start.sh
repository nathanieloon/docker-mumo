#!/bin/bash
if [ ! -f /data/mumo.ini ]
then
  cp /mumo/mumo.ini /data
  sed -i 's/mumo.log/\/data\/mumo.log/' /data/mumo.ini
  sed -i 's/modules\//\/data\/modules\//' /data/mumo.ini
  sed -i 's/modules-enabled\//\/data\/modules-enabled\//' /data/mumo.ini
  sed -i 's/secret =/secret = '"$PWORD"'/' /data/mumo.ini
  sed -i 's/"" =/"'"$YOUTUBE_KEY"'"/' /mumo/modules/key.py

  chmod a+rw /mumo/mumo.ini
  cp -r /mumo/modules /data
  cp -r /mumo/modules-available /data
  cp -r /mumo/modules-enabled /data

  echo Successfully configured mumo. Exiting.
  exit 1
fi

cp -rv /data/modules-enabled /mumo
cp -rv /data/mumo.ini /mumo
./mumo.py