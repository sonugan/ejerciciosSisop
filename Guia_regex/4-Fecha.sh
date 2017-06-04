#Dada una fecha con el formato YYYY-MM-DD pasada por parametros, se indica si la misma es o no válida

fecha="$1";

meses_31="\(\(01\|03\|05\|07\|08\|10\|12\)-\(0[1-9]\|[1-2][0-9]\|3[0-1]\)\)";
meses_30="\(\(04\|05\|09\|11\)-\(0[1-9]\|[1-2][0-9]\|30\)\)";
meses_29="\(02-\(0[1-9]\|[1-2][0-9]\)\)";

val_mes="\($meses_29\|$meses_30\|$meses_31\)";

es_val=$(echo "$fecha" | sed "s/[0-9][0-9][0-9][0-9]-$val_mes/Es valido!!/");

es_val=$(echo "$es_val" | sed "s/$fecha/No es valido!!/");

echo "$es_val";
