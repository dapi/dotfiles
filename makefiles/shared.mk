#
# Shared tasks
#
backup-config:
	@test -e ${CONFIG_PATH} && \
		(test -L ${CONFIG_PATH} && test -e ${MY_CONFIG_PATH} || mv ${CONFIG_PATH} ${CONFIG_PATH}-$(TEMP_DATE)) || \
		true

link-config: backup-config
	@echo "Link config ${CONFIG_PATH} -> ${MY_CONFIG_PATH}"
	@test ! -e ${CONFIG_PATH} && ln -s ${MY_CONFIG_PATH} ~/.config || true

link-home-config: 
	@echo "Link home config ${FILE}"
	@test ! -e ~/${FILE} && ln -s ~/dotfiles/${FILE} ~/

install-tool:
	@echo "Install ${TOOL}"
	@which ${TOOL} > /dev/null || (which brew > /dev/null && brew install ${TOOL} || sudo apt-get install ${TOOL})
