Quick and dirty example:

```
> docker run \
  -e "AWS_DEFAULT_REGION=us-west-2" \
  -e "KMS_VAR=AQEC...1HCn8g==" \
  -e AWS_ACCESS_KEY_ID="AKIAJIYCZ6SZNMPYWSRQ" \
  -e AWS_SECRET_ACCESS_KEY=$(pass aws-secret-key) i\
  -v secrets:/out
  -it lrvick/kms-decrypt
```

You can then source the env file to another container like so:

```
> docker run \
  -v secrets:/secrets.env org/myapp \
  sh -c "source secrets.env; myapp_cmd"
```
