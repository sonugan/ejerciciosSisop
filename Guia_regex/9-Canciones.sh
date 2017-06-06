# LIMITE="00:03:12"

duracion="$1";

es_igual=$(echo "$duracion" | sed "s/00:03:12/Es igual/");

rm1="\(00:03:1[0-1]\)" # 00:03:10 - 00:03:11
rm2="\(00:03:0[0-9]\)" # 00:03:00 - 00:03:09
rm3="\(00:0[0-2]:[0-5][0-9]\)" # 00:00:00 - 00:02:59

es_menor=$(echo "$duracion" | sed "s/$rm1\|$rm2\|$rm3/Es menor/");

rma1="\(00:03:1[3-9]\)" # 00:03:13 - 00:03:19
rma2="\(00:03:[2-5][0-9]\)" # 00:03:20 - 00:03:59
rma3="\(00:0[4-9]:[0-5][0-9]\)" # 00:04:00 - 00:09:59
rma4="\(00:[1-5][0-9]:[0-5][0-9]\)" # 00:10:00 - 00:59:59
rma5="\(0[1-9]:[0-5][0-9]:[0-5][0-9]\)" # 01:00:00 - 09:59:59
rma6="\([1-5][0-9]:[0-5][0-9]:[0-5][0-9]\)" # 10:00:00 - 59:59:59

es_mayor=$(echo "$duracion" | sed "s/$rma1\|$rma2\|$rma3\|$rma4\|$rma5\|$rma6/Es mayor/");

es_igual=$(echo "$es_igual" | sed "s/$duracion//");
es_menor=$(echo "$es_menor" | sed "s/$duracion//");
es_mayor=$(echo "$es_mayor" | sed "s/$duracion//");

echo "$es_igual $es_menor $es_mayor";