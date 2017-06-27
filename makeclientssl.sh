#!/usr/bin/env bash
# make client ssl
# 生成客户端证书
# author ljh
cd /etc/pki/CA

#构建客户端证书私钥,aes256|des3需要输入client.key密码
#openssl genrsa -aes256 -out private/client.key 2048
openssl genrsa -des3 -out private/client.key 2048
#构建客户端证书签发申请,-subj输入相关的信息,组织信息
openssl req -new -key private/client.key -out private/client.csr -subj "/C=CN/ST=Beijing/L=Beijing/O=rootCA/OU=myweb tech/CN=*.test.com"
#签发客户端证书，有效期10年
openssl ca -days 3650 -in private/client.csr -out certs/client.crt -cert certs/ca.crt -keyfile private/ca.key
#客户端证书转化，将crt证书转化为p12格式,需要输入导出密码
openssl pkcs12 -export -cacerts -inkey private/client.key -in certs/client.crt -out certs/client.p12
