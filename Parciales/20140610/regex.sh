#Parametro: PAIS y si es LOCAL o VISITANTE

pais="$1";
condicion="$2";

pais_id=$(grep "^[^,]*,$pais,.*" "Country.List" | sed "s/^[^,]*,\([^,]*\),.*/\1/");

filtro_local="^[^;]*;[^;]*;$pais_id;.*";
filtro_visitante="^[^;]*;[^;]*;[^;]*;$pais_id;.*";

filtro=$(echo "$condicion" | sed "s/LOCAL/$filtro_local/" | sed "s/VISITANTE/$filtro_visitante/");

res=$(grep "$filtro" "Match.Master" 
	| sed "s/^[^;]*;\([^;]*\);[^;]*;[^;]*;\([^;]*\);\([^;]*\);\([^;]*\);.*/\4;\1;\2;\3/"  # date;score1;score2;result
	| sed "s///");