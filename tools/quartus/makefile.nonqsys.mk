
GIT_ROOT 	= $(shell git rev-parse --show-toplevel)
SCRIPT_DIR 	= $(GIT_ROOT)/tools/quartus

include $(SCRIPT_DIR)/makefile.common.mk

$(SOF): pre $(OUT_DIR)
	cd $(OUT_DIR) && quartus_sh --64bit -t $(SCRIPT_DIR)/quartus_build.tcl
