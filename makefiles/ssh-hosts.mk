DOTFILES:=${DOTFILES} ~/.ssh/config

SERVERS:=$(shell cat .ssh/hosts/*.conf | grep "Host " | cut -d " " -f 2 | sort)
REMOTE_SERVER_HOME_DIR:="/home/${USER}"

DSH_PREFIX=dsh_
DSH_HOSTS := $(addprefix $(DSH_PREFIX),$(SERVERS))

servers:
	@echo $(SERVERS)

import-hosts-from-server:
	scp "${SERVER}:${REMOTE_SERVER_HOME_DIR}/dotfiles/.ssh/hosts/*" .ssh/hosts/

.PHONY: $(DSH_HOSTS)
import-hosts: $(DSH_HOSTS)
$(DSH_HOSTS): $(DSH_PREFIX)%:
	@$(MAKE) import-ssh-hosts-from-server SERVER=$*
