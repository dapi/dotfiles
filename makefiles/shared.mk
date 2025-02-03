#
# Shared tasks
#
backup-config:
	@test -e ${CONFIG_PATH} && \
		(test -L ${CONFIG_PATH} && test -e ${MY_CONFIG_PATH} || mv ${CONFIG_PATH} ${CONFIG_PATH}-$(TEMP_DATE)) || \
		true

link-config: backup-config
	@echo "Link config ${MY_CONFIG_PATH} -> ${CONFIG_PATH} (${LINK_DIR})"
	@test ! -e ${CONFIG_PATH} && ln -s ${MY_CONFIG_PATH} ${CONFIG_PATH} || true

link-home-config: 
	@echo "Link home config ~/${FILE}"
	@$(MAKE) backup-config CONFIG_PATH=~/${FILE} MY_CONFIG_PATH=~/dotfiles/${FILE}
	@test ! -e ~/${FILE} && ln -s ~/dotfiles/${FILE} ~/ || true

install-tool:
	@echo "Install ${TOOL}"
	@which ${TOOL} > /dev/null || (which brew > /dev/null && brew install ${TOOL} || sudo apt-get install ${TOOL})
