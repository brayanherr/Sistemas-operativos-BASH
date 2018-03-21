#!/bin/bash

#Programa para sacar la info de procesos, memoria libre y disco libre de la raiz

#Integrantes:
#Brayan Alexander Herrera Ordoñez - 1734471
#Nicolas Bejarano Gordillo - 1631277

#Numero de procesos del sistema
procesos=$(ps ax | tail -n +2 | wc -l)

#Memoria libre del sistema en MB
memoriaTotal=$(free -m | grep Memoria | awk '{print $2}')
memoriaLibre=$(vmstat --unit m | tail -n 1 | awk '{print $4}')

memoriaPorcentual=$((${memoriaLibre} * 100))
memoriaPorcentual=$((${memoriaPorcentual} / ${memoriaTotal}))

discoLibre=$(df | grep root | awk '{print $5}')
#Editamos la cadena del disco que esta en MB
discoLibre=$(echo ${discoLibre:0:-1})

curl --silent --request POST --data "field1=${procesos}&field2=${memoriaPorcentual}&field3=${discoLibre}" "https://api.thingspeak.com/update?api_key=SJ1TC5R3FS4LENIB"
