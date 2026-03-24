#!/bin/bash
#Se necesita realizar un script que permita mediante un #menú realizar distintas operaciones
#sobre un sistema Linux o MacOS.
#Este script utilizará un parámetro optativo y una variable de ambiente llamada FILENAME
#para guardar el nombre de un archivo.
#Para esto se debe crear un menú con las siguientes opciones.
#Se debe tener la carpeta donde esté el script y los archivos subidos a un repositorio de
#github. Un repositorio por grupo y debe ser público.
#Recursos usados: https://www.w3schools.com/bash/bash_script.php

if [ "$1" == "-d" ]; then
    pkill -f consolidar.sh
    rm -rf ~/EPNro1
    exit 0
fi

while true
do
  echo "Elija una opción:"
  echo "1: Crear entorno."
  echo "2: Correr proceso."
  echo "3: Mostrar alumnos ordenados por padrón."
  echo "4: Mostrar las 10 notas más altas del listado."
  echo "5: Mostrar datos de un padrón específico."
  echo "6: Salir."

  read OpcionElegida


case $OpcionElegida in
    1)
        #Uso -p para crear los directorios padre si no existen.
        #En caso de que ya existan, no se mostrará ningún error.
        mkdir -p ~/EPNro1/{entrada,salida,procesado}
        cp consolidar.sh ~/EPNro1/ 2>/dev/null
        chmod +x ~/EPNro1/consolidar.sh 2>/dev/null
        echo "Se han creado los directorios de forma satisfactoria."
        ;;
    2) if [ -d "$HOME/EPNro1/salida" ]; then
          if [ -z "$FILENAME" ]; then
            echo "Ingresar nombre del archivo donde se adjuntara la información:"
            read FILENAME 
            export FILENAME
          fi
          if [ ! -f ~/EPNro1/salida/${FILENAME}.txt ]; then
            touch  ~/EPNro1/salida/${FILENAME}.txt  
          fi
            echo "Se ejecuta el proceso."
            bash ~/EPNro1/consolidar.sh &
      else
          echo "No existe el entorno o está incompleto"
       fi;;     
    3) if [ -d "$HOME/EPNro1/salida" ]; then
         if [ -f ~/EPNro1/salida/${FILENAME}.txt ]; then
            sort -n ~/EPNro1/salida/${FILENAME}.txt
            #Usamos -n para ordenar numericamente, dado que el padrón es el primer número que aparece en cada línea del archivo.
         else
            echo "El archivo FILENAME.txt no existe en la carpeta de salida."
         fi
       else
         echo "No existe el entorno o está incompleto"
       fi;;


    4) if [ -d "$HOME/EPNro1/salida" ]; then
          if [ -f ~/EPNro1/salida/${FILENAME}.txt ]; then
            sort -k5 -n -r ~/EPNro1/salida/${FILENAME}.txt | head -n 10
           #Usamos -k5 para ordenar por la quinta columna, que es donde se encuentra la nota. -n para ordenar numéricamente y -r para ordenar de mayor a menor.
          else
            echo "El archivo FILENAME.txt no existe en la carpeta de salida."
          fi
      else
          echo "No existe el entorno o está incompleto"
       fi;;
    5) if [ -d "$HOME/EPNro1/salida" ]; then
         if [ -f ~/EPNro1/salida/${FILENAME}.txt ]; then
             echo "Ingrese número de padrón:"  
             read padron
           if grep -q "^$padron " ~/EPNro1/salida/${FILENAME}.txt; then
                grep "^$padron " ~/EPNro1/salida/${FILENAME}.txt
             else
                echo "No se encontró ningún alumno con el número de padrón $padron."
           fi
          else
            echo "El archivo FILENAME.txt no existe en la carpeta de salida."
          fi
       else
          echo "No existe el entorno o está incompleto"
       fi;;
    6) 
       echo "Salida exitosa"
       exit 0
       ;;
    *) echo "Opción no válida. Por favor elija una opción del 1 al 6.";;
esac


done
