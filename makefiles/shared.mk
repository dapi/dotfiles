#
# Shared tasks
#
DST_REFERENCE=$(shell readlink $(DST))
BACKUP_FILE=${DST}-${TEMP_DATE}
REAL_REFERENCE=$(shell realpath $(REFERENCE))
# skip backup if destination file does not exits
# skip backup if link content is targed readlink
# backup destination if does not skipped
#
backup-config:
	@test -e ${DST} || \
		( \
			( test -L ${DST} && test "${DST_REFERENCE}" = "${REAL_REFERENCE}" && echo "Target value" ) || \
			( mv ${DST} ${BACKUP_FILE} && echo "Backup ${DST} to ${BACKUP_FILE}" ) \
		) || \
		(rm -f ${DST} && echo "No need to backup") 

link-config: backup-config
	@echo "Link config ${DST} -> ${REFERENCE}"
	@test ! -e ${DST} && ln -s ${REFERENCE} ${DST} || echo "File exixts ${DST}"

# REFERENCE_FILE=$(shell echo "$(DST)"  | sed -e 's/~\///g')
REFERENCE_FILE=$(shell echo $(DST) | sed -e 's/.*\///g')
link-home-config: 
	@echo "Link ~/${REFERENCE_FILE}"
	@$(MAKE) backup-config REFERENCE=~/dotfiles/${REFERENCE_FILE}
	 @test -e ${DST} || ln -s ${REAL_REFERENCE} ${DST}

install-tool:
	@echo "Install ${TOOL}"
	@which ${TOOL} > /dev/null || (which brew > /dev/null && brew install ${TOOL} || sudo apt-get install ${TOOL})

guard-%:
	@ if [ "${${*}}" = "" ]; then \
		echo "Environment variable $* not set"; \
		exit 1; \
	fi
