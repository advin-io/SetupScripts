#!/usr/bin/env bash

echo $(which brew)

if [ $(which brew) -eq 0 ]; then
    echo Where brew at
fi

echo Found that mofo
