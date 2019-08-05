#!/bin/bash

#TODO: se gli argomenti non contengono una data in formato ISO interrompi
if [ $1 != `date -d "$1" -I` ]; then
  echo "data non in formato YYYY-MM-DD"
  exit
fi

#se la data di inizio è maggiore della data di fine interrompi
if [ `date -d "$1" +%s` -gt `date -d "$2" +%s` ]; then
  echo "data di inizio maggiore della data di fine"
  exit
fi

start_date=`date -d "$1" -I`
end_date=`date -d "$2" -I`

while [ $(date -d $start_date +"%Y%m%d") -le $(date -d $end_date +"%Y%m%d") ] ; do
  php OLAP.php -c add -d $start_date -f dettaglio_utenti
  start_date=`date -d "$start_date +1 day" -I`
#  sleep 1
done
