NAME =			silverstripe
VERSION =		latest
VERSION_ALIASES =	3.2.2 3.2 3
TITLE =			SilverStripe
DESCRIPTION =		SilverStripe with MySQL
SOURCE_URL =		https://github.com/shoaibali/scaleway-silverstripe

IMAGE_VOLUME_SIZE =	50G
IMAGE_BOOTSCRIPT =	stable
IMAGE_NAME =		SilverStripe 3.2.2


## Image tools  (https://github.com/scaleway/image-tools)
all:	docker-rules.mk
docker-rules.mk:
	wget -qO - http://j.mp/scw-builder | bash
-include docker-rules.mk
