#########################################################
# Makefile for quartus flow
#########################################################

#########################################################
# Common variable
#########################################################

GIT_ROOT 	= $(shell git rev-parse --show-toplevel)
SCRIPT_DIR 	= $(GIT_ROOT)/tools/quartus

#########################################################
# Project specific variable
#########################################################

# device part
PART ?= EP2C35F672C7
# device family
FAMILY ?= Cyclone II
# project name
PROJECT ?=
# top level name
TOP ?=
# verilog source files
VERILOG ?=
# verilog define
DEFINE ?=
# sdc files
SDC	?=
# pin assignment files
PIN ?=
# project output directory
OUT_DIR ?= outputs


export QUARTUS_PART 	= $(PART)
export QUARTUS_FAMILY 	= $(FAMILY)
export QUARTUS_PRJ 		= $(PROJECT)
export QUARTUS_TOP    	= $(TOP)
export QUARTUS_VERILOG  = $(VERILOG)
export QUARTUS_SEARCH   = $(SEARCH)
export QUARTUS_SDC		= $(SDC)
export QUARTUS_QIP		= $(QIP)
export QUARTUS_PIN		= $(PIN)
export QUARTUS_DEFINE	= $(DEFINE)

QIP	= $(OUT_DIR)/$(QSYS)/synthesis/$(QSYS).qip
SOF = $(OUT_DIR)/$(PROJECT).sof

#########################################################
# Build process
#########################################################

build: sof
sof : $(SOF)
qip : $(QIP)
qsys : $(QIP)

$(OUT_DIR):
	mkdir -p $(OUT_DIR)

$(QIP):
	qsys-generate $(QSYS_DIR)/$(QSYS).qsys --search-path="$(QSYS_SEARCH)"  --family=$(FAMILY)  --part=$(PART) --synthesis=$(QSYS_SYN_LANG) --output-directory=$(OUT_DIR)/$(QSYS) --clear-output-directory

qsys-edit:
	qsys-edit $(QSYS_DIR)/$(QSYS).qsys --search-path="$(QSYS_SEARCH)"

pgm: $(SOF)
	quartus_pgm --mode JTAG -o "p;$(SOF)"

pgmonly:
	quartus_pgm --mode JTAG -o "p;$(SOF)"

clean: clean_qsys
	rm -rf $(OUT_DIR)

clean_qsys:
	rm -rf $(QSYS_DIR)/$(QSYS)*.rpt $(QSYS_DIR)/$(QSYS).cmp $(QSYS_DIR)/$(QSYS).html $(QSYS_DIR)/$(QSYS).sopcinfo
