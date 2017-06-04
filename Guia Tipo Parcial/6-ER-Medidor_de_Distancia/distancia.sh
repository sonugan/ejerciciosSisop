##Parametros: un string con los siguientes campos separados por el caracter %
###Localidad origen
###Localidad destino
###numero de ruta

param="$1";

loc_origen=$(echo "$param" | sed 's/^\([^%]*\)%.*/\1/');
loc_dest=$(echo "$param" | sed 's/^[^%]*%\([^%]*\)%.*/\1/');
ruta=$(echo "$param" | sed 's/^[^%]*%[^%]*%\(.*\)/\1/');

return "$loc_origen";