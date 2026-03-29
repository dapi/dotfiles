DOTFILES:=${DOTFILES} ~/.ssh/config

SSH_HOSTS_OS_DIR := .ssh/hosts/current-os
SSH_HOSTS_OS_TARGET := $(if $(filter Darwin,$(UNAME)),darwin,linux)

APPLIES:=$(APPLIES) ssh-hosts-os-link

ssh-hosts-os-link:
	@if [ "$$(readlink $(SSH_HOSTS_OS_DIR))" != "$(SSH_HOSTS_OS_TARGET)" ]; then \
		rm -f $(SSH_HOSTS_OS_DIR); \
		ln -s $(SSH_HOSTS_OS_TARGET) $(SSH_HOSTS_OS_DIR); \
		echo "SSH hosts: linked current-os -> $(SSH_HOSTS_OS_TARGET)"; \
	fi

SERVERS:=$(shell cat .ssh/hosts/*.conf .ssh/hosts/$(SSH_HOSTS_OS_TARGET)/*.conf 2>/dev/null | grep "Host " | cut -d " " -f 2 | sort -u)
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
	@$(MAKE) import-hosts-from-server SERVER=$*
