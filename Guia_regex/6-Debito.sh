

#VISA: 4XXX-XXXX-XXXX-XXXX
#MASTER: [51-55]XX-XXXX-XXXX-XXXX
#AMEX: [34-37]XXX-XXXXX-XXXXX

visa="\(4[0-9][0-9][0-9]\(-\([0-9]\)\{4,4\}\)\{3,3\}\)";
master="\(5[1-5][0-9][0-9]\(-\([0-9]\)\{4,4\}\)\{3,3\}\)/";
amex="\(3[4-7][0-9][0-9][0-9]\(-\([0-9]\)\{5,5\}\)\{2,2\}\)";

lineas=$(sed "s/$visa/\1:VISA/" "6-tarjetas.dat" | sed "s/$master\1:MASTERCARD/" | sed "s/$amex/\1:AMEX/");

echo "$lineas";