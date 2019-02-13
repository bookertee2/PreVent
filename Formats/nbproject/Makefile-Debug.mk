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
CND_CONF=Debug
CND_DISTDIR=dist
CND_BUILDDIR=build

# Include project Makefile
include Makefile

# Object Directory
OBJECTDIR=${CND_BUILDDIR}/${CND_CONF}/${CND_PLATFORM}

# Object Files
OBJECTFILES= \
	${OBJECTDIR}/AnonymizingSignalSet.o \
	${OBJECTDIR}/Base64.o \
	${OBJECTDIR}/BasicSignalData.o \
	${OBJECTDIR}/BasicSignalSet.o \
	${OBJECTDIR}/CpcXmlReader.o \
	${OBJECTDIR}/CsvWriter.o \
	${OBJECTDIR}/DataRow.o \
	${OBJECTDIR}/FileNamer.o \
	${OBJECTDIR}/Formats.o \
	${OBJECTDIR}/Hdf5Reader.o \
	${OBJECTDIR}/Hdf5Writer.o \
	${OBJECTDIR}/MatWriter.o \
	${OBJECTDIR}/NullReader.o \
	${OBJECTDIR}/OffsetTimeSignalSet.o \
	${OBJECTDIR}/Options.o \
	${OBJECTDIR}/Reader.o \
	${OBJECTDIR}/SignalData.o \
	${OBJECTDIR}/SignalDataWrapper.o \
	${OBJECTDIR}/SignalSet.o \
	${OBJECTDIR}/SignalSetWrapper.o \
	${OBJECTDIR}/SignalUtils.o \
	${OBJECTDIR}/StpJsonReader.o \
	${OBJECTDIR}/StpXmlReader.o \
	${OBJECTDIR}/StreamChunkReader.o \
	${OBJECTDIR}/TdmsReader.o \
	${OBJECTDIR}/TimezoneOffsetTimeSignalSet.o \
	${OBJECTDIR}/WfdbReader.o \
	${OBJECTDIR}/WfdbWriter.o \
	${OBJECTDIR}/Writer.o \
	${OBJECTDIR}/XmlReaderBase.o \
	${OBJECTDIR}/ZlReader.o \
	${OBJECTDIR}/ZlReader2.o


# C Compiler Flags
CFLAGS=-m64

# CC Compiler Flags
CCFLAGS=-std=c++17
CXXFLAGS=-std=c++17

# Fortran Compiler Flags
FFLAGS=

# Assembler Flags
ASFLAGS=

# Link Libraries and Options
LDLIBSOPTIONS=`pkg-config --libs zlib` -lhdf5.dll -lhdf5_cpp.dll `pkg-config --libs matio` `pkg-config --libs expat` -L../libtdms/dist/Debug/Cygwin-Windows -ltdms  

# Build Targets
.build-conf: ${BUILD_SUBPROJECTS}
	"${MAKE}"  -f nbproject/Makefile-${CND_CONF}.mk ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/libFormats.${CND_DLIB_EXT}

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/libFormats.${CND_DLIB_EXT}: ../libtdms/dist/Debug/Cygwin-Windows/libtdms.dll

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/libFormats.${CND_DLIB_EXT}: ${OBJECTFILES}
	${MKDIR} -p ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}
	g++ -o ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/libFormats.${CND_DLIB_EXT} ${OBJECTFILES} ${LDLIBSOPTIONS} `wfdb-config --libs` -lstdc++fs -shared

${OBJECTDIR}/AnonymizingSignalSet.o: AnonymizingSignalSet.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat`    -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/AnonymizingSignalSet.o AnonymizingSignalSet.cpp

${OBJECTDIR}/Base64.o: Base64.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat`    -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Base64.o Base64.cpp

${OBJECTDIR}/BasicSignalData.o: BasicSignalData.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat`    -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/BasicSignalData.o BasicSignalData.cpp

${OBJECTDIR}/BasicSignalSet.o: BasicSignalSet.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat`    -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/BasicSignalSet.o BasicSignalSet.cpp

${OBJECTDIR}/CpcXmlReader.o: CpcXmlReader.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat` -std=c++14   -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/CpcXmlReader.o CpcXmlReader.cpp

${OBJECTDIR}/CsvWriter.o: CsvWriter.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat`    -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/CsvWriter.o CsvWriter.cpp

${OBJECTDIR}/DataRow.o: DataRow.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat` -std=c++14   -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/DataRow.o DataRow.cpp

${OBJECTDIR}/FileNamer.o: FileNamer.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat`    -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/FileNamer.o FileNamer.cpp

${OBJECTDIR}/Formats.o: Formats.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat` -std=c++14   -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Formats.o Formats.cpp

${OBJECTDIR}/Hdf5Reader.o: Hdf5Reader.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat` -std=c++14   -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Hdf5Reader.o Hdf5Reader.cpp

${OBJECTDIR}/Hdf5Writer.o: Hdf5Writer.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat` -std=c++14   -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Hdf5Writer.o Hdf5Writer.cpp

${OBJECTDIR}/MatWriter.o: MatWriter.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat` -std=c++14   -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/MatWriter.o MatWriter.cpp

${OBJECTDIR}/NullReader.o: NullReader.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat` -std=c++14   -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/NullReader.o NullReader.cpp

${OBJECTDIR}/OffsetTimeSignalSet.o: OffsetTimeSignalSet.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat`    -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/OffsetTimeSignalSet.o OffsetTimeSignalSet.cpp

${OBJECTDIR}/Options.o: Options.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat`    -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Options.o Options.cpp

${OBJECTDIR}/Reader.o: Reader.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat` -std=c++14   -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Reader.o Reader.cpp

${OBJECTDIR}/SignalData.o: SignalData.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat` -std=c++14   -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/SignalData.o SignalData.cpp

${OBJECTDIR}/SignalDataWrapper.o: SignalDataWrapper.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat`    -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/SignalDataWrapper.o SignalDataWrapper.cpp

${OBJECTDIR}/SignalSet.o: SignalSet.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat` -std=c++14   -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/SignalSet.o SignalSet.cpp

${OBJECTDIR}/SignalSetWrapper.o: SignalSetWrapper.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat`    -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/SignalSetWrapper.o SignalSetWrapper.cpp

${OBJECTDIR}/SignalUtils.o: SignalUtils.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat` -std=c++14   -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/SignalUtils.o SignalUtils.cpp

${OBJECTDIR}/StpJsonReader.o: StpJsonReader.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat` -std=c++14   -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/StpJsonReader.o StpJsonReader.cpp

${OBJECTDIR}/StpXmlReader.o: StpXmlReader.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat` -std=c++14   -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/StpXmlReader.o StpXmlReader.cpp

${OBJECTDIR}/StreamChunkReader.o: StreamChunkReader.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat` -std=c++14   -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/StreamChunkReader.o StreamChunkReader.cpp

${OBJECTDIR}/TdmsReader.o: TdmsReader.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat` -std=c++14   -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/TdmsReader.o TdmsReader.cpp

${OBJECTDIR}/TimezoneOffsetTimeSignalSet.o: TimezoneOffsetTimeSignalSet.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat`    -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/TimezoneOffsetTimeSignalSet.o TimezoneOffsetTimeSignalSet.cpp

${OBJECTDIR}/WfdbReader.o: WfdbReader.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat`    -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/WfdbReader.o WfdbReader.cpp

${OBJECTDIR}/WfdbWriter.o: WfdbWriter.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat` -std=c++14   -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/WfdbWriter.o WfdbWriter.cpp

${OBJECTDIR}/Writer.o: Writer.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat` -std=c++14   -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/Writer.o Writer.cpp

${OBJECTDIR}/XmlReaderBase.o: XmlReaderBase.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat` -std=c++14   -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/XmlReaderBase.o XmlReaderBase.cpp

${OBJECTDIR}/ZlReader.o: ZlReader.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat` -std=c++14   -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/ZlReader.o ZlReader.cpp

${OBJECTDIR}/ZlReader2.o: ZlReader2.cpp
	${MKDIR} -p ${OBJECTDIR}
	${RM} "$@.d"
	$(COMPILE.cc) -g -Wall -I../libtdms/include `pkg-config --cflags zlib` `pkg-config --cflags matio` `pkg-config --cflags expat`    -MMD -MP -MF "$@.d" -o ${OBJECTDIR}/ZlReader2.o ZlReader2.cpp

# Subprojects
.build-subprojects:
	cd ../libtdms && ${MAKE}  -f Makefile CONF=Debug

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r ${CND_BUILDDIR}/${CND_CONF}
	${RM} -r ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/libtdms.dll
	${RM} ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/libFormats.${CND_DLIB_EXT}

# Subprojects
.clean-subprojects:
	cd ../libtdms && ${MAKE}  -f Makefile CONF=Debug clean

# Enable dependency checking
.dep.inc: .depcheck-impl

include .dep.inc
