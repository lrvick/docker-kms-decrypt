#!/bin/bash

source /etc/profile

unset IFS
rm /out/secrets.env
for line in $(env | egrep '^KMS_'); do
	key="${line%%=*}"
	encrypted_value=${line#*=}
	decrypted_value_base64=$( \
		aws kms decrypt \
			--ciphertext-blob fileb://<(echo "$encrypted_value" | base64 -d) \
			--query Plaintext \
			--output text
	)
	decrypted_value=$(echo $decrypted_value_base64 | base64 -d)
	echo "key=$key"
	echo "encrypted_value=$encrypted_value"
	echo "export $key=$decrypted_value" >> /out/secrets.env
done
