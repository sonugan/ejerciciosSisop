#Recibe un email por parametro e indica si es o no valido

email="$1";

exten="\.\(com\|\(com\.[a-Z]\{1,\}\)\)$";

es_val=$(echo "$email" | sed "s/^[^@]\{1,\}@[^\.]\{1,\}$exten/Es valido!!/");

es_val=$(echo "$es_val" | sed "s/$email/No es valido!!/");

echo "$es_val";