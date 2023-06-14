###########################################################################
#
#    SWIG-generated python wrapper for the Linear Arrangement Library
#    Copyright (C) 2021-2023 LAL-project developers
#         Lluís Alemany Puig
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

# USER_BUILD: debug/release
# ENVIR: devel (development) / dist (distribution)
#	* development: only for developers
#	* distribution: used to install the python interface to your
#		system.

########################################################################

# compilation is debug by default
ifeq ($(USER_BUILD), )
	USER_BUILD = debug
endif
# distribution is development by default
ifeq ($(USER_ENVIRONMENT), )
	ENVIR = development
endif

########################################################################

ifneq ($(USER_BUILD),debug)
ifneq ($(USER_BUILD),release)
$(info Error: invalid value for USER_BUILD variable: $(USER_BUILD))
$(info .    https://github.com/LAL-project/linear-arrangement-library.git)
$(info .    https://github.com/LAL-project/python-interface.git)
endif
endif

ifneq ($(USER_ENVIRONMENT),development)
ifneq ($(USER_ENVIRONMENT),distribution)
$(info Error: invalid value for USER_ENVIRONMENT variable: $(USER_ENVIRONMENT))
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

$(info Compilation mode: $(USER_BUILD))
ifeq ($(USER_BUILD),debug)
$(info .    'debug':   slower binaries, but errors are caught with "self-explanatory" error messages)
else
$(info .    'release': produces faster binaries)
endif

$(info Link against: $(ENVIR))
ifeq ($(USER_ENVIRONMENT),development)
$(info .    'development':  LAL's development distribution)
else
$(info .    'distribution': LAL's installed version)
endif

########################################################################
# VARIABLES

# ------------
# LAL location
LAL_INC_DIR = $(USER_LAL_INC_DIR)
LAL_LIB_DIR = $(USER_LAL_LIB_DIR)

$(info LAL source)
$(info .    LAL include header files in: $(LAL_INC_DIR))
$(info .    LAL library files in:        $(LAL_LIB_DIR))

# --------------------------
# System libraries' location

GMP_INC_DIR=$(USER_GMP_INC_DIR)
GMP_LIB_DIR=$(USER_GMP_LIB_DIR)

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

# ------------------
# Python information

# Python directories
PYTHON_INC_DIR = $(USER_PYTHON_HEADERS)
PYTHON_LIB_DIR = $(USER_PYTHON_LIBRARY)

MAJOR_VERSION_PYTHON = $(USER_PYTHON_MAJOR_VERSION)
MINOR_VERSION_PYTHON = $(USER_PYTHON_MINOR_VERSION)

# Directory where LAL's interface will be installed to
LAL_INSTALLATION_DIR = $(USER_INSTALLATION_DIR)

include Makefile.pythonsource

$(info File formats)
$(info .    LAL's library extension:  $(LIBRARY_EXTENSION))
$(info .    Python modules extension: $(SO_EXT))

$(info Python linkage)
$(info .    Major version of python:    $(MAJOR_VERSION_PYTHON))
$(info .    Minor version of python:    $(MINOR_VERSION_PYTHON))
$(info .    Python include directory:   $(PYTHON_INC_DIR))
ifneq ($(OS_ID),linux)
$(info .    Python library directory:   $(PYTHON_LIB_DIR))
$(info .    Linkage flag against major: $(MAJOR_PY_LINK))
$(info .    Linkage flag against minor: $(MINOR_PY_LINK))
endif
$(info .    Installation directory:     $(LAL_INSTALLATION_DIR))
$(info .    Other linkage flags:        $(EXTRA_FLAGS))

# --------------------------
# Architecture of the system

ARCH 			= $(shell getconf LONG_BIT)
ARCH_DIR 		= $(OS_DIR)/$(ARCH)

# ---------------
# SWIG executable

$(info Python linkage)

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

ifeq ($(USER_BUILD),debug)
	SWIG_FLAGS	+= -DDEBUG
else ifeq ($(USER_BUILD),release)
	SWIG_FLAGS	+= -DNDEBUG
endif

SWIG_VERSION = $(shell $(SWIG_EXE) -version | grep ^SWIG | sed 's/^.* //g')
SWIG_VERSION_LTE_402 = $(shell ./compare_versions.sh swig $(SWIG_VERSION) "<=" 4.0.2)

SWIG_LANG_FLAGS = -c++ -python
# Add '-py3' flag for versions 4.0.2 or lower
ifeq ($(SWIG_VERSION_LTE_402),1)
	SWIG_LANG_FLAGS += -py3
endif

$(info Swig information)
$(info .    Version:        '$(SWIG_VERSION)')
$(info .    Language flags: '$(SWIG_LANG_FLAGS)')

SWIG_FLAGS += -I$(LAL_INC_DIR)

# -----------------------------
# Compiler to be used and flags

ifeq ($(OS_ID),windows)
	# ------------------
	# WINDOWS USERS ONLY
	
	CXX		= g++
	FLAGS	= -std=c++17 -fPIC -fopenmp -O3
	LFLAGS	= -fPIC -O3 -Wl,-O3
	
else ifeq ($(OS_ID),linux)
	# ----------------
	# LINUX USERS ONLY
	
	CXX		= g++
	FLAGS	= -std=c++17 -fPIC -fopenmp -O3
	LFLAGS	= -fPIC -O3 -Wl,-O3
	
else ifeq ($(OS_ID),macos)
	# ----------------
	# MACOS USERS ONLY
	
	CXX		= /usr/local/Cellar/gcc/11.2.0/bin/g++-11
	FLAGS	= -std=c++17 -fPIC -fopenmp -O3
	LFLAGS	= -fPIC -O3 -Wl,-O3
	
endif

# set lib and flags according to the mode of compilation
ifeq ($(USER_BUILD),debug)
	# -----------------
	# compilation flags
	
	FLAGS	+= -g -DDEBUG -D_GLIBCXX_DEBUG
	LFLAGS	+= -DDEBUG -D_GLIBCXX_DEBUG
	
else ifeq ($(USER_BUILD),release)
	# -----------------
	# compilation flags
	
	FLAGS	+= -UDEBUG -DNDEBUG
	LFLAGS	+= -DNDEBUG -UDEBUG
	
endif

# ---------------------------------------------------------------------
# set dependencies for the python modules and the destination directory

ifeq ($(USER_BUILD),debug)
	ifneq ($(LAL_LIB_DIR), )
		LIBRARY_SHARED_DEP += $(LAL_LIB_DIR)/liblal.$(LIBRARY_EXTENSION)
	endif
	
	INTERFACE_DIRECTORY	= lal
	
else ifeq ($(USER_BUILD),release)
	ifneq ($(LAL_LIB_DIR), )
		LIBRARY_SHARED_DEP += $(LAL_LIB_DIR)/liblaloptimized.$(LIBRARY_EXTENSION)
	endif
	
	INTERFACE_DIRECTORY	= laloptimized
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

ifeq ($(USER_BUILD),debug)
	ifneq ($(LAL_LIB_DIR), )
		LIBS += -L $(LAL_LIB_DIR)
	endif
	LIBS += -llal
	
else ifeq ($(USER_BUILD),release)
	ifneq ($(LAL_LIB_DIR), )
		LIBS += -L $(LAL_LIB_DIR)
	endif
	LIBS += -llaloptimized
	
endif

ifneq ($(GMP_LIB_DIR), )
	LIBS += -L $(GMP_LIB_DIR)
endif
LIBS += -lgmp

LIBS += -fopenmp
LIBS += -lpthread
LIBS += $(EXTRA_FLAGS)

ifeq ($(OS_ID),windows)

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

else ifeq ($(OS_ID),macos)

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
$(info .    Link flags:       $(LFLAGS))

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
directories: $(ARCH_DIR)/laloptimized $(ARCH_DIR)/lal
$(ARCH_DIR)/laloptimized:
	mkdir -p $(ARCH_DIR)/laloptimized
$(ARCH_DIR)/lal:
	mkdir -p $(ARCH_DIR)/lal

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
	mkdir -p $(LAL_INSTALLATION_DIR)/$(INTERFACE_DIRECTORY)
	cp $(ALL_INSTALL_SO_FILES) $(LAL_INSTALLATION_DIR)/$(INTERFACE_DIRECTORY)/
	cp $(ALL_INSTALL_PY_FILES) $(LAL_INSTALLATION_DIR)/$(INTERFACE_DIRECTORY)/

uninstall:
	rm -rf $(LAL_INSTALLATION_DIR)/$(INTERFACE_DIRECTORY)/
	rm -rf $(LAL_INSTALLATION_DIR)/$(INTERFACE_DIRECTORY)/
