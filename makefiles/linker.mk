TEMP_DATE:=$(shell date "+%F-%T")
DST_REFERENCE=$(shell readlink $(DST))
BACKUP_FILE=${DST}-${TEMP_DATE}
REAL_REFERENCE=$(shell realpath $(REFERENCE))

#
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

REFERENCE_FILE=$(shell echo $(DST) | sed -e 's:$(HOME)/::g')
REFERENCE=~/dotfiles/${REFERENCE_FILE}
link-home-config: backup-config 
	@echo "Link ~/${REFERENCE_FILE} to ${REFERENCE}"
	@test -e ${DST} || ln -s ${REAL_REFERENCE} ${DST}
