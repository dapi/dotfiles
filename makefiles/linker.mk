TEMP_DATE:=$(shell date "+%F-%T")
DST_REFERENCE=$(shell readlink $(DST))
BACKUP_FILE=${DST}-${TEMP_DATE}
REAL_REFERENCE=$(shell realpath $(REFERENCE))

#
# skip backup if destination file does not exist
# skip backup if already a symlink to the correct target
# backup destination otherwise (file, directory, or wrong symlink)
#
backup-config:
	@if [ -L "$(DST)" ] && [ "$(DST_REFERENCE)" = "$(REAL_REFERENCE)" ]; then \
		: ; \
	elif [ -e "$(DST)" ] || [ -L "$(DST)" ]; then \
		mv "$(DST)" "$(BACKUP_FILE)" && echo "Backup $(DST) to $(BACKUP_FILE)"; \
	fi

REFERENCE_FILE=$(shell echo $(DST) | sed -e 's:$(HOME)/::g')
REFERENCE=~/dotfiles/${REFERENCE_FILE}
link-home-config: backup-config
	@echo "Link ~/${REFERENCE_FILE} to ${REFERENCE}"
	@test -e ${DST} || ln -s ${REAL_REFERENCE} ${DST}
