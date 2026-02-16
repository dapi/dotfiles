APPLIES:=$(APPLIES) rtk

RTK_VERSION=$(shell curl -fsSL https://api.github.com/repos/rtk-ai/rtk/releases/latest | jq -r '.tag_name')
RTK_ARCH=$(shell uname -m)
RTK_OS=$(shell uname -s | tr '[:upper:]' '[:lower:]')
ifeq ($(RTK_OS),darwin)
  RTK_TARGET=$(RTK_ARCH)-apple-darwin
else
  RTK_TARGET=$(RTK_ARCH)-unknown-linux-gnu
endif

rtk: ~/bin/rtk

~/bin/rtk:
	@echo "Install rtk $(RTK_VERSION)"
	@mkdir -p ~/bin
	@curl -fsSL "https://github.com/rtk-ai/rtk/releases/download/$(RTK_VERSION)/rtk-$(RTK_TARGET).tar.gz" | tar -xz -C ~/bin rtk
	@chmod a+x ~/bin/rtk
