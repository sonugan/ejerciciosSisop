##Paraemtros: un string con los siguientes datos separados por |
###ID Sesion
###IP origen
###Reingreso
###Localidad
##Salida estandar:
###LIsta de precios <id de lista>
###Una linea por cada producto	<producto> + <precio bruto>

localidad=$(echo "$1" | sed "s/^[^|]*|[^|]*|[^|]*|\([^|]*\)/\1/");

#IdLista;Pais;Provincia;Localidad;Estado
id_lista=$(grep "^[^;]*;[^;]*;[^;]*;$localidad;.*" "ListaDePrecios.dat" | sed "s/^\([^;]*\);.*/\1/");

echo "Lista de precios $id_lista";

#producto;precio neto;precio bruto;precio promo no cliente;precio promo cliente
sed "s/^\([^;]*\);[^;]*;\([^;]*\);.*/\1 + \2/" "$id_lista";