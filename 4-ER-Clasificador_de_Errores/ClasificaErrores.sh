##Paraemtros:
###Codigo de error

##Salida: 
###Clasificacion del error

codigo=$1;
#ID_CLASS;ERROR_CODE;ERROR_DESCRIPCION;ERROR_CLASS;LAST_UPDATED_BY;LAST_UPDATE_DATE
linea=$(grep "^[^;]*;$codigo;.*" "CLASE_DE_ERRORES.dat");

grepVacio="$?";

sinClasificacion=$(echo "$grepVacio" | sed "s/1/<>/"); #Si grep no encontró nada
sinClasificacion=$(echo "$sinClasificacion" | sed "s/0//");

clasificacion=$(echo "$linea" | sed "s/^\([^;]*;\)\{3,3\}\([^;]*\);.*/\2/");
clasificacion=$(echo $clasificacion | sed "s/$linea//");

echo "$clasificacion$sinClasificacion";