#!/bin/bash

# probably only useful for me, sorry
export PATH=/usr/bin:/usr/bin/core_perl:/usr/bin/vendor_perl

# always execute in THIS dir
self=$(readlink -e "$0") || exit 1
self=$(dirname "${self}") || exit 1
cd "$self"

name=test
tmpfile=/tmp/.magnet.$EUID.$$.$(date +%s).$RANDOM

openscad -o ${name}.stl ${name}.scad

slic3r \
	 --layer-height 0.25 \
	 --perimeters 1 \
	 --solid-layers 5 \
	 --nozzle-diameter 0.35 \
	 --filament-diameter 1.75 \
	 --temperature 220 \
	 --print-center 100,100 \
	 --skirts 5 \
	 --fill-density 0.12 \
	 -o ${tmpfile} ${name}.stl

sed -i 's/M104 S200/M104 S220/' ${tmpfile}
sed -i 's/M109 S200/M109 S220/' ${tmpfile}

mv -f ${tmpfile} ${name}.gcode
