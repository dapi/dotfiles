PACKAGES:=$(PACKAGES) mise

package:
	@echo "Install ${PACKAGE}"
	@which ${PACKAGE} > /dev/null || (which brew > /dev/null && brew install ${PACKAGE} || sudo apt-get install ${PACKAGE})
