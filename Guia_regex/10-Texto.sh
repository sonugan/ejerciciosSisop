opcion="$1";
palabra="$2";


if [ "$opcion"=="a" ]
then
	res1=$(grep "$palabra" "10-lipsum.txt"); #Busco la palabra pasada por parametro
	echo "$res1";
fi

if [ "$opcion"=="b" ] #ELimino la 5ta palabra de las lineas iniciadas en E
then
	res2=$(sed "s/^\(\(e\|E\)[^ ]* [^ ]* [^ ]* [^ ]* \)[^ ]*\( .*\)/\1ELIMINADO\3/" "10-lipsum.txt"); 
	echo "$res2";
fi

if [ "$opcion"=="c" ]
then
	res3=$(sed "/.*sed$/d" "10-lipsum.txt"); #Elimino las finalizadas en sed
	echo "$res3";
if [ "$opcion"=="d" ]
then
	res4=$(sed "/.*/a #COMENTARIO: Este es un comentario" "10-lipsum.txt"); #Agrego un comentario al finalizar cada linea
	echo "$res4";
fi


