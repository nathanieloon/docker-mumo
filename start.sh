#!/bin/bash
if [ ! -f /data/mumo.ini ]
then
  cp /mumo/mumo.ini /data
  sed -i 's/mumo.log/\/data\/mumo.log/' /data/mumo.ini
  sed -i 's/modules\//\/data\/modules\//' /data/mumo.ini
  sed -i 's/modules-enabled\//\/data\/modules-enabled\//' /data/mumo.ini
  sed -i 's/secret =/secret = '"$PWORD"'/' /data/mumo.ini
  sed -i 's/api_key = ""/api_key = "'"$YOUTUBE_KEY"'"/' /mumo/modules/key.py

  chmod a+rw /mumo/mumo.ini
  cp -R /mumo/modules /data
  cp -R /mumo/modules-available /data
  cp -R /mumo/modules-enabled /data

  echo Successfully configured mumo. Exiting.
  exit 1
fi

cp -Rv /data/modules-enabled /mumo
cp -Rv /data/mumo.ini /mumo
./mumo.py