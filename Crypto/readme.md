# Crypto

# FUN

## The challenge

Here is the flag:

bblntx{hi1w_rfy_1fj3ox3o_d0mwhi1rr_lw3k0af}

It has been encoded with some strange, "unbreakable" cipher, will you find what it is?

Hint: The key is the last name of the one who first described (the REAL inventor) this famous "unbreakable" cipher ... that is not caesar!

## Writeup

Its a vigenere encoding with the key :  BELLASO

axactf{th1s_guy_1nv3nt3d_s0meth1ng_aw3s0me}


# The return of the FUN!

## The challenge

Now, we have a very passionated guy that encoded the flag with "axa" ... How to decode it? I wonder ...

aaxxxxaxaaaaxxxxaaxxxxaxaaxxxaaxaaaxaxxxaaxxaaxxaaaaxaaxaaaxxaaxxaaxaaaxxaaxaxxxaaaxxaxxxaaxaaaxxaaxxxaxaaxaaaxxaaxxaaaxaxaaaaaxaaxxxaaxaaaxxaxxaaaaxxaxaaaxxxxxaaaxaxxxxaaxxxxxaxaaaaaxxaaxxxaxxaaxxxxxxaaxxxaxaxaaaaaxaaaxaaaxxaaxxxaxxaaxaaaxaaxaxxxxaxaaaaaxaaxaaxaxaaaxaxaxaaxaaxxxxaaxaaaxxaaxxxaxaaaxxxxxaaxaaxxxxaaxxaaxaxaaaaaxaaaxxaaxaaaxaxxxxaaxxaaxaaaxxxxxaaaxxaaxaaaaaxa
only 2 letters huh? And it's not using any cipher or any super complex encoding methodology ...

## Writeup

It's a binary encoding a=0 and x=1

110000101111000011000010110001101110100011001100111101101110011001101110011010001110010001101110011000101101110011001110101111101100011011100100111100101110000011101000011000001011111001100010011000000110001010111110111011100110001001101110110100001011111011011010111010101101100001101110011000101110000011011000011001101011111011100110111010000110011011100000111001101111101

adding a 0 before and converting it to Ascii (https://www.binaryhexconverter.com/binary-to-ascii-text-converter)

axactf{s74r71ng_crypt0_101_w17h_mul71pl3_st3ps}



# Really Secure Algorithm

## The challenge

This is no joke: a Really Secure Algorithm!

It seems super complicated, but it's actually just some maths!
n = 3933040695755526216762716530555881218562437822109718517317094901575710404204917634838294452247801386017769920938299165176835481978219593420852584340147439
e = 65537
c = 3488475450415021653455336991104105602572835488702692132129068809171867415698353125829534574176985347210440330955204838700013961865299526399268522151822300

Will you be able to decrypt it?

## Writeup

we need to find the 2 primes number of n. Using factorbd : 
http://factordb.com/index.php?query=3933040695755526216762716530555881218562437822109718517317094901575710404204917634838294452247801386017769920938299165176835481978219593420852584340147439


```python
import gmpy2
from gmpy2 import mpz,mpq,mpfr,mpc
from Crypto.Util.number import long_to_bytes
n = 3933040695755526216762716530555881218562437822109718517317094901575710404204917634838294452247801386017769920938299165176835481978219593420852584340147439
e = 65537
c = 3488475450415021653455336991104105602572835488702692132129068809171867415698353125829534574176985347210440330955204838700013961865299526399268522151822300

p=62004237518891373354112961422235264296687007938732994465343345946285469463571
q=63431804875549228523832313909380901212822869160400031133964616962306316224309

print(p*q)

phi = (p-1)*(q-1)
d = gmpy2.invert(e,phi)
pt = long_to_bytes(pow(c,d,n)).decode()
print("Flag is : " + str(pt))
```
Flag is : axa_ctf{rs4_1s_n0t_th4t_c0mpl1c4t3d_1_gu355}



# MD5

## The challenge


I don't think that my usage of MD5 is very good. What do you think?

http://52.220.153.59:5000/

```javascript
const m = require('md5');

app.get('/', (req, res) => {
  const secret = process.env.SECRET;
  const pwd = req.query.pass;

  if (pwd) {
    if (parseInt(m(secret)) === parseInt(m(pwd))) {
      res.send(`Here is the flag: ${process.env.FLAG}`);
    } else {
      res.send('Nope!');
    }
  } else {
    res.send('Send me a password ("pass") query param!');
  }
});
```


## Writeup

we see the comparaison on parsint in JS. So if the MD5 is starting with 55as5as55ef5, parseInt will return 55.
So a collision is higly probable.

A simple bruteforce :

```bash
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
```

we find : 
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaN

http://52.220.153.59:5000/?pass=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaN

lead to : axactf{md5_15_n0t_v3ry_53cur3_4nyw4y}
