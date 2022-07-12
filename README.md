# pomerium-quickstart
Pomerium's Quick Start Guide

Creating this detail quick start guide since Pomerium main's guide is quite vague and assume some prior knowledge.

### Software pre-requisite
- [Docker](https://docs.docker.com/get-docker/)
- [brew](https://brew.sh/) - so that installing linux binaries without sudo is easier
- [acme.sh](https://github.com/acmesh-official/acme.sh) - for automating getting of (wildcard) certs from zerossl or letsencrypt


### Get SSL certificates
- Install acme.sh via one of these method as describe on this [link](https://github.com/acmesh-official/acme.sh/wiki/How-to-install)

- acme.sh has many DNS-API to many different DNS provider. You can refer to this [link](https://github.com/acmesh-official/acme.sh/wiki/dnsapi) to choose which service is hosting your domain. In this example, we shall use [CloudFlare](https://github.com/acmesh-official/acme.sh/wiki/dnsapi#1-cloudflare-option)

- [Create a wildcard subdomain](https://developers.cloudflare.com/dns/manage-dns-records/reference/wildcard-dns-records/) in CloudFlare and point it to the IP where pomerium will be setup. I will turn off the Proxy Status for that entry. Entries for: `local.mydomain.com` and `*.local.mydomain.com`

- Generate an API token at CloudFlare via thier [API-Token](https://dash.cloudflare.com/profile/api-tokens) page and it should have `Zone`, `DNS` and `Edit` permission for at least one zone for the domain that you own. Remember the key or put the key in the `Makefile`

```
# Makefile

export CF_TOKEN ?= vbXTlFbTiO3yq_9erdsfhqcXiCqloFxvxMDel
```

- To issue certificate for your domain run:
```
DOMAIN=local.mydomain.com make acme-issue-certs
```
But default, unless you run `acme.sh --set-default-ca  --server letsencrypt`, the default CA is from zerossl

You should see something like this at then end of the process:
```
...
7F0xkS/kHNABnz7Adhq1BgY8hsefFIwDRZtVMTKbxhGMYGIlzf9TgA3/RKJOsdak
0G6Sq1UTOc9+DwGM6KurVHydZGdZw0WMC6rMzcH65pOYfHFtNMqwHd4lw8JihUSw
BBMAWykAAhq+37gSVp2gcN8BmmYNIX4sWRVUOe5STOsm06A5Jm+qLlVcdnDS7/+4
y/8=
-----END CERTIFICATE-----
[Mon Jul 11 22:11:17 PDT 2022] Your cert is in: /Users/meme/.acme.sh/local.mydomain.com/local.mydomain.com.cer
[Mon Jul 11 22:11:17 PDT 2022] Your cert key is in: /Users/meme/.acme.sh/local.mydomain.com/local.mydomain.com.key
[Mon Jul 11 22:11:17 PDT 2022] The intermediate CA cert is in: /Users/meme/.acme.sh/local.mydomain.com/ca.cer
[Mon Jul 11 22:11:17 PDT 2022] And the full chain certs is there: /Users/meme/.acme.sh/local.mydomain.com/fullchain.cer   

```

- Finally, copy or move these 2 files into your git-root
```
cp /Users/meme/.acme.sh/local.mydomain.com/fullchain.cer ./fullchain.pem
cp /Users/meme/.acme.sh/local.mydomain.com/local.mydomain.com.key ./privkey.pem
```

That is all for the certificates!

### Using GitHub as an IDP



### Reference Links:
- [ACME_CloudFlare](https://www.keyvanfatehi.com/2021/09/11/using-acme-sh-in-cloudflare-dns-mode-to-easily-maintain-wildcard-ssl-certificate-for-apache-server-on-ubuntu-20-04/)
