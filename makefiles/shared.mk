#
# Shared tasks
#
backup-config:
	test -d ${CONFIG_PATH} && \
		(test -L ${CONFIG_PATH} && test -e ${MY_CONFIG_PATH} || mv ${CONFIG_PATH} ${CONFIG_PATH}-$(TEMP_DATE)) || \
		/bin/true

link-config: backup-config
	test ! -d ${CONFIG_PATH} && ln -s ${MY_CONFIG_PATH} ~/.config/

link-home-config: 
	$(MAKE) link-config CONFIG_PATH=~/${FILE} MY_CONFIG_PATH=~/.config/${FILE}

install-tool:
	which ${TOOL} || 
		(which brew && brew install ${TOOL} || sudo apt-get install ${TOOL})

