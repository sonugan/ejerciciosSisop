#Dada una fecha con el formato mm/dd/aaaa pasada por parametro, se la reformatea a dd/mm/aaaa

fecha="$1";

fecha_ref=$(echo "$fecha" | sed "s/\([0-9][0-9]\)\/\([0-9][0-9]\)\/\([0-9][0-9]\)/\2\/\1\/\3/");

echo "$fecha_ref";