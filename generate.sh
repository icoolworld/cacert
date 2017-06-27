openssl req -new -newkey rsa:2048 -sha256 -nodes -out test.com.csr -keyout test.com.key -subj "/C=CN/ST=Beijing/L=Beijing/O=website Inc./OU=Web Security/CN=*.test.com"
