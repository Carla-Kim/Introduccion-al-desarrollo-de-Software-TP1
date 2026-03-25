#!/bin/bash

for f in "$HOME/EPNro1/entrada/"*.txt; do
    if [ -f "$f" ]; then
        cat "$f" >> "$HOME/EPNro1/salida/${FILENAME}.txt"
        mv "$f" "$HOME/EPNro1/procesado/"
    fi
done

