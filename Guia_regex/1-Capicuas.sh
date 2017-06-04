#Dado un numero entero de 3 digitos pasado por parametro, retorna el capicua

num="$1";

capicua=$(echo "$num" | sed "s/\([0-9]\)\([0-9]\)\([0-9]\)/\1\2\3\3\2\1/");

echo "$capicua";