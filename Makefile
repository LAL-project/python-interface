###########################################################################
#
#    SWIG-generated python wrapper for the Linear Arrangement Library
#    Copyright (C) 2021 Lluís Alemany Puig
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as published
#    by the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program. If not, see <https://www.gnu.org/licenses/>.
#
#    Contact:
#
#       Lluís Alemany Puig (lalemany@cs.upc.edu)
#           LARCA (Laboratory for Relational Algorithmics, Complexity and Learning)
#           CQL (Complexity and Quantitative Linguistics Lab)
#           Jordi Girona St 1-3, Campus Nord UPC, 08034 Barcelona.   CATALONIA, SPAIN
#           Webpage: https://cqllab.upc.edu/people/lalemany/
#
###########################################################################

# BUILD: debug/release
# ENVIR: devel (development) / dist (distribution)
#	* development: only for developers
#	* distribution: used to install the python interface to your
#		system.
# ANACONDA: yes/no

########################################################################

# compilation is debug by default
ifeq ($(BUILD), )
BUILD = debug
endif
# distribution is devel by default
ifeq ($(ENVIR), )
ENVIR = devel
endif
# do not install for Anaconda
ifeq ($(ANACONDA), )
ANACONDA = no
endif

########################################################################

ifneq ($(BUILD),debug)
ifneq ($(BUILD),release)
$(info Error: invalid value for BUILD variable: $(BUILD))
$(info .    https://github.com/LAL-project/linear-arrangement-library.git)
$(info .    https://github.com/LAL-project/python-interface.git)
endif
endif

ifneq ($(ENVIRONMENT),development)
ifneq ($(ENVIRONMENT),distribution)
$(info Error: invalid value for ENVIRONMENT variable: $(ENVIR))
$(info .    https://github.com/LAL-project/linear-arrangement-library.git)
$(info .    https://github.com/LAL-project/python-interface.git)
endif
endif

ifneq ($(ANACONDA),yes)
ifneq ($(ANACONDA),no)
$(info Error: invalid value for ANACONDA variable: $(ANACONDA))
$(info .    https://github.com/LAL-project/linear-arrangement-library.git)
$(info .    https://github.com/LAL-project/python-interface.git)
endif
endif

########################################################################

OS_ID = unknown
ifeq ($(OS),Windows_NT)
	OS_ID = windows
else
	# from https://gist.github.com/sighingnow/deee806603ec9274fd47
	UNAME_S = $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		OS_ID = linux
	endif
	
	ifeq ($(UNAME_S),Darwin)
		OS_ID = macos
	endif
endif

$(info Building for OS '$(OS_ID)')

ifeq ($(OS_ID),unknown)
$(info Error: Unknown Operative System '$(OS_ID)'. Contact the developers)
$(info .    https://github.com/LAL-project/linear-arrangement-library.git)
$(info .    https://github.com/LAL-project/python-interface.git)
endif

########################################################################
# OUTPUT DEBUG INFORMATION

$(info Compilation mode: $(BUILD))
$(info .    'release' = produces faster binaries)
$(info .    'debug'   = slower binaries, but errors are caught with self-explanatory error messages)
$(info Link against: $(ENVIR))
$(info .    'development'  = development distribution)
$(info .    'distribution' = installed version)

########################################################################
# VARIABLES

# ------------
# LAL location

ifeq ($(ENVIR), devel)
	# this assumes that development happens within the "python-interface/" directory
	
	LAL_INC_DIR = ../linear-arrangement-library
	ifeq ($(BUILD), debug)
		LAL_LIB_DIR = ../linear-arrangement-library/lal-debug
		
	else
		LAL_LIB_DIR = ../linear-arrangement-library/lal-release
		
	endif
else
	include Makefile.lalsource
	
endif

$(info LAL source)
$(info .    LAL include header files in: $(LAL_INC_DIR))
$(info .    LAL library files in:        $(LAL_LIB_DIR))

# --------------------------
# System libraries' location

include Makefile.gmpsource

$(info GMP source)
$(info .    GMP include header files in: $(GMP_INC_DIR))
$(info .    GMP library files in:        $(GMP_LIB_DIR))

# ------------------------------------------
# extension of the python interface binaries

OS_DIR	= $(OS_ID)
ifeq ($(OS_ID),windows)
	# LAL library's extension (liblaldebug.dll)
	LIBRARY_EXTENSION = dll
	# Python module's extension
	SO_EXT = pyd

else ifeq ($(OS_ID),linux)
	# LAL library's extension (liblaldebug.so)
	LIBRARY_EXTENSION = so
	# Python module's extension
	SO_EXT = so

else ifeq ($(OS_ID),macos)
	# LAL library's extension (liblaldebug.dylib)
	LIBRARY_EXTENSION = dylib
	# Python module's extension
	SO_EXT = so

endif

# ---------------
# Python location

include Makefile.pythonsource

$(info File formats)
$(info .    LAL's library extension:  $(LIBRARY_EXTENSION))
$(info .    Python modules extension: $(SO_EXT))

$(info Python linkage)
$(info .    Install for Anaconda:       $(ANACONDA))
$(info .    Minor version of python:    $(MINOR_VERSION_PYTHON))
$(info .    Python include directory:   $(PYTHON_INC_DIR))
$(info .    Python library directory:   $(PYTHON_LIB_DIR))
$(info .    Linkage flag against major: $(MAJOR_PY_LINK))
$(info .    Linkage flag against minor: $(MINOR_PY_LINK))
$(info .    Installation directory:     $(LAL_PY_DEST))
$(info .    Other linkage flags:        $(EXTRA_FLAGS))

# --------------------------
# Architecture of the system

ARCH 			= $(shell getconf LONG_BIT)
ARCH_DIR 		= $(OS_DIR)/$(ARCH)

# ---------------
# SWIG executable

SWIG_EXE		= swig
# SWIG flags
SWIG_FLAGS_32	= -DSWIGWORDSIZE32
SWIG_FLAGS_64 	= -DSWIGWORDSIZE64

ifeq ($(OS_ID),windows)
	SWIG_FLAGS	+= $(SWIG_FLAGS_32)

else ifeq ($(OS_ID),linux)
	SWIG_FLAGS	+= $(SWIG_FLAGS_$(ARCH))

else ifeq ($(OS_ID),macos)
	SWIG_FLAGS	+= 

endif

ifeq ($(BUILD),debug)
	SWIG_FLAGS	+= -DDEBUG

else ifeq ($(BUILD),release)
	SWIG_FLAGS	+= -DNDEBUG

endif

# -------------------
# Compiler to be used

ifeq ($(OS_ID),windows)
	# ------------------
	# WINDOWS USERS ONLY
	
	CXX			= g++
	FLAGS		= -std=c++17 -fPIC -fopenmp

else ifeq ($(OS_ID),linux)
	# ----------------
	# LINUX USERS ONLY
	
	CXX			= g++
	FLAGS		= -std=c++17 -fPIC -fopenmp

else ifeq ($(OS_ID),macos)
	# ----------------
	# MACOS USERS ONLY
	
	CXX			= /usr/local/Cellar/gcc/11.2.0/bin/g++-11
	FLAGS		= -std=c++17 -fPIC -fopenmp

endif

# set lib and flags according to the mode of compilation
ifeq ($(BUILD),debug)
	# -----------------
	# compilation flags

	FLAGS		+= -g -O3 -DDEBUG -D_GLIBCXX_DEBUG
	
else ifeq ($(BUILD),release)
	# -----------------
	# compilation flags

	FLAGS		+= -O3 -UDEBUG -DNDEBUG
	
endif


# ---------------------------------------------------------------------
# set dependencies for the python modules and the destination directory

ifeq ($(BUILD),debug)
	ifeq ($(ENVIRONMENT),development)
		LIBRARY_SHARED_DEP += $(LAL_LIB_DIR)/liblaldebug.$(LIBRARY_EXTENSION)
	
	else
		LIBRARY_SHARED_DEP +=
	
	endif

	INTERFACE_DIRECTORY	+= laldebug

else ifeq ($(BUILD),release)
	ifeq ($(ENVIRONMENT),development)
		LIBRARY_SHARED_DEP += $(LAL_LIB_DIR)/liblal.$(LIBRARY_EXTENSION)
	
	else
		LIBRARY_SHARED_DEP +=
	
	endif

	INTERFACE_DIRECTORY	+= lal
endif

# ----------------------
# complete include flags

ifneq ($(LAL_INC_DIR), )
	INCLUDES += -I $(LAL_INC_DIR)
	
endif

ifneq ($(GMP_INC_DIR), )
	INCLUDES += -I $(GMP_INC_DIR)
	
endif

ifneq ($(PYTHON_INC_DIR), )
	INCLUDES += -I $(PYTHON_INC_DIR)
	
endif

# ----------------------
# complete linkage flags

ifeq ($(BUILD),debug)
	ifneq ($(LAL_LIB_DIR), )
		LIBS += -L $(LAL_LIB_DIR) -llaldebug
	
	else
		LIBS += -llaldebug
	
	endif

else ifeq ($(BUILD),release)
	ifneq ($(LAL_LIB_DIR), )
		LIBS += -L $(LAL_LIB_DIR) -llal
	
	else
		LIBS += -llal
	
	endif

endif

ifneq ($(GMP_LIB_DIR), )
	LIBS += -L $(GMP_LIB_DIR) -lgmp
	
else
	LIBS += -lgmp
	
endif

LIBS += -fopenmp
LIBS += -lpthread
LIBS += $(EXTRA_FLAGS)

ifeq ($(ANACONDA),yes)
	LIBS += $(MAJOR_PY_LINK) $(MINOR_PY_LINK)

else ifeq ($(ANACONDA),no)
	ifeq ($(PYTHON_LIB_DIR), )
		ifneq ($(MAJOR_PY_LINK), )
			LIBS += $(MAJOR_PY_LINK)
			
		endif
		
		ifneq ($(MINOR_PY_LINK), )
			LIBS += $(MINOR_PY_LINK)
			
		endif
	else
		ifneq ($(MAJOR_PY_LINK), )
			LIBS += -L $(PYTHON_LIB_DIR) $(MAJOR_PY_LINK)
			
		endif
		
		ifneq ($(MINOR_PY_LINK), )
			LIBS += -L $(PYTHON_LIB_DIR) $(MINOR_PY_LINK)
			
		endif
	endif
endif

$(info Compiler)
$(info .    Path:             $(CXX))
$(info .    Flags:            $(FLAGS))
$(info .    Includes:         $(INCLUDES))
$(info .    Linked libraries: $(LIBS))

# ----------------------
# DEPENDENCIES (headers)

include Makefile.headers

# ----------------
# MODULE variables

include Makefile.module.variables

########################################################################
# GOALS

all: directories $(ALL_INSTALL_SO_FILES) $(ALL_INSTALL_PY_FILES)
python_interfaces: directories $(ALL_INSTALL_PY_FILES)
	rm -f $(ARCH_DIR)/temp.cxx	# clean up after yourself
directories: $(ARCH_DIR)/lal $(ARCH_DIR)/laldebug
$(ARCH_DIR)/lal:
	mkdir -p $(ARCH_DIR)/lal
$(ARCH_DIR)/laldebug:
	mkdir -p $(ARCH_DIR)/laldebug

########################################################################
# BUILDING RULES

include Makefile.module.rules

########################################################################
# CLEANING RULES

cleanwrap:
	rm -f $(ARCH_DIR)/$(INTERFACE_DIRECTORY)/*.cxx
	rm -f $(ARCH_DIR)/$(INTERFACE_DIRECTORY)/*.o

cleanso:
	rm -f $(ARCH_DIR)/$(INTERFACE_DIRECTORY)/*.$(SO_EXT)

clean:
	rm -rf $(ARCH_DIR)/$(INTERFACE_DIRECTORY)/*

distclean:
	rm -rf $(ARCH_DIR)

install: $(LAL_SO)
	mkdir -p $(LAL_PY_DEST)/$(INTERFACE_DIRECTORY)
	cp $(ALL_INSTALL_SO_FILES) $(LAL_PY_DEST)/$(INTERFACE_DIRECTORY)/
	cp $(ALL_INSTALL_PY_FILES) $(LAL_PY_DEST)/$(INTERFACE_DIRECTORY)/

uninstall:
	rm -rf $(LAL_PY_DEST)/$(INTERFACE_DIRECTORY)/
	rm -rf $(LAL_PY_DEST)/$(INTERFACE_DIRECTORY)/
