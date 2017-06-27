#!/usr/bin/env bash
# make CA MIDDLE
# 生成中间CA证书,二级CA证书
# author ljh
dir=/etc/pki/CA
cd $dir

#构建中间CA证书私钥,aes256|des3需要输入mca.key密码
#openssl genrsa -aes256 -out private/mca.key 2048
openssl genrsa -out private/mca.key 2048
#openssl rsa -in private/mca.key -out private/mca.key
#构建中间CA证书签发申请,-subj输入相关的信息,组织信息
openssl req -new -key private/mca.key -out private/mca.csr -subj "/C=CN/ST=Beijing/L=Beijing/O=rootCA/OU=middleCA tech/CN=*.middleca.com"
#签发二级CA证书，有效期100年,使用sha256签名,利用上级根密钥和证书进行签发,这里是ca.key,ca.crt
openssl ca -extensions v3_ca -in private/mca.csr -out certs/mca.crt -cert certs/ca.crt -keyfile private/ca.key

#二级CA证书转化，将crt证书转化为p12格式,需要输入导出密码
openssl pkcs12 -export -cacerts -inkey private/mca.key -in certs/mca.crt -out certs/mca.p12
