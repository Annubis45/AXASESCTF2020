#!/bin/bash    
password=""
passwordtemp=""
passwordreel=""
echo $cmd
#yxhhy3rme2cxdjnfbtnfyjrja19tev8zetm1xzffbv9ibdfuzh0=
arrayName=('a' 'b' 'c' 'd' 'e' '=' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z' 'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z' '0' '1' '2' '3' '4' '5' '6' '7' '8' '9')
while true; do
a=0
for i in "${arrayName[@]}"; do
passwordtemp="$password$i"
echo $password
cmd=$(curl 'http://52.220.153.59:5000/?pass='$passwordtemp)

if [[ $cmd == *"Nope!"* ]]; then
  a=$a+1;
  echo $passwordtemp":  Nope!"
else
  passwordreel=$passwordtemp
  break
fi
done
echo $passwordreel
password="a"$password
done
#axactf{md5_15_n0t_v3ry_53cur3_4nyw4y}
#http://52.220.153.59:5000/?pass=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaN