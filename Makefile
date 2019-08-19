REGION?=eu-west-1
PROFILE?=
STAGE?=
KEY?=

AWS_CLI := aws --profile $(PROFILE) --region $(REGION)

make_key:
	$(AWS_CLI) ssm put-parameter --name /medihunter/$(STAGE)/secret_key --value $(KEY) --type SecureString

deploy: make_key
	AWS_SDK_LOAD_CONFIG=1 sls deploy \
		--verbose \
		--stage $(STAGE) \
		--region $(REGION) \
		--aws-profile $(PROFILE) \
