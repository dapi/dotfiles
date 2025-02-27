#
# Shared tasks
#
backup-config:
	@test -e ${CONFIG_PATH} && \
		(test -L ${CONFIG_PATH} && test -e ${MY_CONFIG_PATH} || mv ${CONFIG_PATH} ${CONFIG_PATH}-$(TEMP_DATE)) || \
		true

link-config: backup-config
	@echo "Link config ${MY_CONFIG_PATH} -> ${CONFIG_PATH}"
	@test ! -e ${CONFIG_PATH} && ln -s ${MY_CONFIG_PATH} ${CONFIG_PATH} || true

FILE_TO_LINK=$(shell echo "$(FILE)"  | sed -e 's/~\///g')
link-home-config: 

	@echo "Link home config ~/${FILE_TO_LINK}"
	@$(MAKE) backup-config CONFIG_PATH=~/${FILE_TO_LINK} MY_CONFIG_PATH=~/dotfiles/${FILE_TO_LINK}
	@test ! -e ~/${FILE_TO_LINK} && ln -s ~/dotfiles/${FILE_TO_LINK} ~/ || true

install-tool:
	@echo "Install ${TOOL}"
	@which ${TOOL} > /dev/null || (which brew > /dev/null && brew install ${TOOL} || sudo apt-get install ${TOOL})

guard-%:
	@ if [ "${${*}}" = "" ]; then \
		echo "Environment variable $* not set"; \
		exit 1; \
	fi
