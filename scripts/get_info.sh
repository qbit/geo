#!/bin/sh

for i in $(cat frac_wells ); do
	LL=$(grep -A 13 "As Drilled Location" ${i}.html | grep 37 | awk -F\< '{print $1}' | sed -e "s/\//\^/g" | awk -F\^ '{print $2 ","$1}')
	DEPTH=$(grep -A 3 "Prop Depth/Form" ${i}.html | awk -F\> '{print $3}' | awk -F\< '{print $1}' | tr '\n' ',' | awk -F, '{print $2}')
	echo "insert into wells (name,is_water,permitno,the_geom,depth_well) values ('${i}',true,'',st_setsrid(st_makepoint(${LL}),4326),${DEPTH});"
done
