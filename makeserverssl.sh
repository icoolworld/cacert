#!/usr/bin/env bash
# make CA ROOT
# 生成服务器证书
# author ljh
cd /etc/pki/CA

#构建服务器证书私钥,aes256|des3需要输入server.key密码
#openssl genrsa -aes256 -out private/server.key 2048
openssl genrsa -des3 -out private/server.key 2048
#构建服务器证书签发申请,-subj输入相关的信息,组织信息
openssl req -new -key private/server.key -out private/server.csr -subj "/C=CN/ST=Beijing/L=Beijing/O=rootCA/OU=myweb tecn/CN=*.test.com"
#签发服务器证书，有效期100年,使用sha256签名,使用扩展签发x509 v3版本
openssl x509 -req -days 3650 -sha256 -extensions v3_req -CA certs/ca.crt -CAkey private/ca.key -CAcreateserial -in private/server.csr -out certs/server.crt
#服务器证书转化，将crt证书转化为p12格式,需要输入导出密码
openssl pkcs12 -export -cacerts -inkey private/server.key -in certs/server.crt -out certs/server.p12

#nginx免密码重启
#openssl rsa -in server.key -out server.key.nopassword
