#!/usr/bin/env bash
# make CA ROOT
# 生成根证书
# author ljh
cd /etc/pki/CA

#构建根证书私钥,aes256|des3需要输入ca.key密码
#openssl genrsa -aes256 -out private/ca.key 2048
openssl genrsa -des3 -out private/ca.key 2048
#构建根证书签发申请,-subj输入相关的信息,组织信息
openssl req -new -key private/ca.key -out private/ca.csr -subj "/C=CN/ST=Beijing/L=Beijing/O=rootCA/OU=rootCA tech/CN=*.rootca.com"
#签发根证书，有效期100年,使用sha256签名
openssl x509 -req -days 36500 -sha256 -extensions v3_ca -signkey private/ca.key -in private/ca.csr -out certs/ca.crt
#根证书转化，将crt证书转化为p12格式,需要输入导出密码
openssl pkcs12 -export -cacerts -inkey private/ca.key -in certs/ca.crt -out certs/ca.p12
