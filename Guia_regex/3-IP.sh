#Dado un numero de IP pasado por parametro, se indica si el mismo es valido o no

ip="$1";

es_val=$(echo "$ip" | sed "s/^[0-9][0-9][0-9].[0-9][0-9][0-9].[0-9].[0-9]/Es valido/");

es_val=$(echo "$es_val" | sed "s/$ip/No es valido/");

echo "$es_val";