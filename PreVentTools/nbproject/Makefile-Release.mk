#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Environment
MKDIR=mkdir
CP=cp
GREP=grep
NM=nm
CCADMIN=CCadmin
RANLIB=ranlib
CC=gcc
CCC=h5c++
CXX=h5c++
FC=gfortran
AS=as

# Macros
CND_PLATFORM=Cygwin-Windows
CND_DLIB_EXT=dll
CND_CONF=Release
CND_DISTDIR=dist
CND_BUILDDIR=build

# Include project Makefile
include Makefile

# Object Directory
OBJECTDIR=${CND_BUILDDIR}/${CND_CONF}/${CND_PLATFORM}

# Object Files
OBJECTFILES= \
	${OBJECTDIR}/AttributeUtils.o \
	${OBJECTDIR}/ClippingSignalSet.o \
	${OBJECTDIR}/H5Cat.o \
	${OBJECTDIR}/TimeParser.o \
	${OBJECTDIR}/main.o


# C Compiler Flags
CFLAGS=

# CC Compiler Flags
CCFLAGS=-Wno-deprecated -O0 -std=c++17
CXXFLAGS=-Wno-deprecated -O0 -std=c++17

# Fortran Compiler Flags
FFLAGS=

# Assembler Flags
ASFLAGS=

# Link Libraries and Options
LDLIBSOPTIONS=-L../Formats/dist/Debug/Cygwin-Windows -lFormats -L../libtdms/dist/Debug/Cygwin-Windows -ltdms

# Build Targets
.build-conf: ${BUILD_SUBPROJECTS}
	"${MAKE}"  -f nbproject/Makefile-${CND_CONF}.mk ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/preventtools.exe

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/preventtools.exe: ../Formats/dist/Debug/Cygwin-Windows/libFormats.dll

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/preventtools.exe: ../libtdms/dist/Debug/Cygwin-Windows/libtdms.dll

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/preventtools.exe: ${OBJECTFILES}
	${MKDIR} -p ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}
	${LINK.cc} -o ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/preventtools ${OBJECTFILES} ${LDLIBSOPTIONS}

${OBJECTDIR}/AttributeUtils.o: AttributeUtils.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -Wall -I../Formats -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/AttributeUtils.o AttributeUtils.cpp

${OBJECTDIR}/ClippingSignalSet.o: ClippingSignalSet.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -Wall -I../Formats -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/ClippingSignalSet.o ClippingSignalSet.cpp

${OBJECTDIR}/H5Cat.o: H5Cat.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -Wall -I../Formats -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/H5Cat.o H5Cat.cpp

${OBJECTDIR}/TimeParser.o: TimeParser.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -Wall -I../Formats -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/TimeParser.o TimeParser.cpp

${OBJECTDIR}/main.o: main.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -O2 -Wall -I../Formats -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/main.o main.cpp

# Subprojects
.build-subprojects:
	cd ../Formats && ${MAKE}  -f Makefile CONF=Debug
	cd ../libtdms && ${MAKE}  -f Makefile CONF=Debug

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r ${CND_BUILDDIR}/${CND_CONF}
	${RM} -r ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/libFormats.dll ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/libtdms.dll
	${RM} ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/preventtools.exe

# Subprojects
.clean-subprojects:
	cd ../Formats && ${MAKE}  -f Makefile CONF=Debug clean
	cd ../libtdms && ${MAKE}  -f Makefile CONF=Debug clean

# Enable dependency checking
.dep.inc: .depcheck-impl

include .dep.inc
