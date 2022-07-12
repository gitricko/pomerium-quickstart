export CF_Token ?= vbXTlFbTiO3xxxxXiCqloFxvxMDel
export CF_Account_ID ?= $(shell curl -s -X GET "https://api.cloudflare.com/client/v4/zones"  -H "Authorization: Bearer $(CF_Token)" | jq -r '.result[0].account.id' )
export CF_Zone_ID ?= $(shell curl -s -X GET "https://api.cloudflare.com/client/v4/zones"  -H "Authorization: Bearer $(CF_Token)" | jq -r '.result[0].id')

IP_ADDR := $(shell ifconfig -a | grep "inet " | awk 'NR==1{print $$2}')
export DOMAIN ?= $(IP_ADDR).sslip.io

test-get-cloudflare-ids:
	@echo CF_Account_ID=$(CF_Account_ID)
	@echo CF_Zone_ID=$(CF_Zone_ID)

acme-issue-certs:
	~/.acme.sh/acme.sh --issue --dns dns_cf  -d $(DOMAIN)  -d "*.$(DOMAIN)"