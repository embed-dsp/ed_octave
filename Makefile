
# Copyright (c) 2021-2023 embed-dsp, All Rights Reserved.
# Author: Gudmundur Bogason <gb@embed-dsp.com>

# https://wiki.octave.org/Building

PACKAGE_NAME = octave

PACKAGE_VERSION = 8.1.0

PACKAGE = $(PACKAGE_NAME)-$(PACKAGE_VERSION)

# ==============================================================================

# Determine system.
SYSTEM = unknown
ifeq ($(findstring Linux, $(shell uname -s)), Linux)
	SYSTEM = linux
endif
ifeq ($(findstring MINGW32, $(shell uname -s)), MINGW32)
	SYSTEM = mingw32
endif
ifeq ($(findstring MINGW64, $(shell uname -s)), MINGW64)
	SYSTEM = mingw64
endif
ifeq ($(findstring CYGWIN, $(shell uname -s)), CYGWIN)
	SYSTEM = cygwin
endif

# Determine machine.
MACHINE = $(shell uname -m)

# Architecture.
ARCH = $(SYSTEM)_$(MACHINE)

# ==============================================================================

# Set number of simultaneous jobs (Default 8)
ifeq ($(J),)
	J = 8
endif

# System configuration.
CONFIGURE_FLAGS =

# Compiler.
CFLAGS = -Wall -O2
CXXFLAGS = -Wall -O2

# Configuration for linux system.
ifeq ($(SYSTEM),linux)
	# Compiler.
	CC = /usr/bin/gcc
	CXX = /usr/bin/g++
	# Installation directory.
	INSTALL_DIR = /opt
endif

# Installation directory.
PREFIX = $(INSTALL_DIR)/$(PACKAGE_NAME)/$(PACKAGE)
# EXEC_PREFIX = $(PREFIX)/$(ARCH)

# ==============================================================================

all:
	@echo "ARCH   = $(ARCH)"
	@echo "PREFIX = $(PREFIX)"
	@echo ""
	@echo "## Get Source Code"
	@echo "make download"
	@echo ""
	@echo "## Build"
	@echo "make prepare"
	@echo "make configure"
	@echo "make compile [J=...]"
	@echo ""
	@echo "## Install"
	@echo "[sudo] make install"
	@echo ""
	@echo "## Cleanup"
	@echo "make clean"
	@echo ""


.PHONY: download
download:
	-mkdir src
	cd src && wget -nc https://mirror.fcix.net/gnu/octave/$(PACKAGE).tar.gz


.PHONY: prepare
prepare:
	-mkdir build
	cd build && tar zxf ../src/$(PACKAGE).tar.gz


.PHONY: configure
configure:
	-mkdir -p build/$(PACKAGE)-obj
	cd build/$(PACKAGE)-obj && ../$(PACKAGE)/configure --prefix=$(PREFIX) $(CONFIGURE_FLAGS)
#	cd build/$(PACKAGE)-obj && ../$(PACKAGE)/configure --prefix=$(PREFIX) --exec_prefix=$(EXEC_PREFIX) $(CONFIGURE_FLAGS)


.PHONY: compile
compile:
	cd build/$(PACKAGE)-obj && make -j$(J)


.PHONY: install
install:
	cd build/$(PACKAGE)-obj && make install


.PHONY: clean
clean:
	-rm -rf build/$(PACKAGE)-obj

# ==============================================================================

# I didn't find texi2dvi, but it's only a problem if you need to
# reconstruct the DVI version of the manual
# sudo dnf install texinfo-tex-6.7-8.fc33.x86_64

# I didn't find icotool, but it's only a problem if you need to
# reconstruct octave-logo.ico, which is the case if you're building from
# VCS sources.
# sudo dnf install icoutils-0.32.3-7.fc33.x86_64

# I didn't find rsvg-convert, but it's only a problem if you need to
# reconstruct octave-logo-*.png, which is the case if you're building
# from VCS sources.
# sudo dnf install librsvg2-tools-2.50.3-1.fc33.x86_64

# configure: error: BLAS and LAPACK libraries are required
# sudo dnf install blas.x86_64
# sudo dnf install blas-devel.x86_64
# sudo dnf install lapack.x86_64
# sudo dnf install lapack-devel.x86_64

# checking for qhull.h... no
# WARNING: Qhull library not found.  This will result in loss of functionality for some geometry functions.
# sudo dnf install qhull.x86_64
# sudo dnf install qhull-devel.x86_64

# checking for library containing tputs... no
# WARNING: I couldn't find -ltermcap, -lterminfo, -lncurses, -lcurses, or -ltermlib
# sudo dnf install ncurses.x86_64
# sudo dnf install ncurses-devel.x86_64

# checking for rl_set_keyboard_input_timeout in -lreadline... no
# WARNING: I need GNU Readline 4.2 or later
# sudo dnf install readline.x86_64
# sudo dnf install readline-devel.x86_64

# Qt
# sudo dnf install qt5-*devel*

# OpenGL
# FIXME: 

# gl2ps
# sudo dnf install gl2ps.x86_64
# sudo dnf install gl2ps-devel.x86_64

# sndfile
# sudo dnf install libsndfile.x86_64
# sudo dnf install libsndfile-devel.x86_64

# PortAudio
# sudo dnf install portaudio.x86_64
# sudo dnf install portaudio-devel.x86_64

# GraphicsMagick++
# sudo dnf install GraphicsMagick-c++.x86_64
# sudo dnf install GraphicsMagick-c++-devel.x86_64

# curl
# sudo dnf install libcurl
# sudo dnf install libcurl-devel
