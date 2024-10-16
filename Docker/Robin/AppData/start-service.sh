#!/bin/sh

SCRIPT_DIR=`dirname "$0"`

#### Base path eg. /mnt/opt/bluecardinal/server/
# TEM_PATH=
# BASE_PATH=$(cd -P .. && pwd -P)
BASE_PATH=.
JAR_FILE=${BASE_PATH}/bluecardinal-core.jar

#### Bluecardinal server node id.
GROUP_ID="BC_SERVER_05042020"

CONFIG_FILES=""
ARGS=$1
JAVA_OPTION="-d64 -server -Xmx1024m -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:+UseCMSInitiatingOccupancyOnly -XX:+ScavengeBeforeFullGC -XX:+CMSScavengeBeforeRemark -XX:+ParallelRefProcEnabled -XX:+DisableExplicitGC -verbose:gc -Xloggc:${BASE_PATH}/logs/gc.log -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=100 -XX:GCLogFileSize=10M -XX:+PrintGCDateStamps -XX:+PrintGCTimeStamps -XX:+PrintGCDetails -XX:+PrintTenuringDistribution -XX:+PrintCommandLineFlags -XX:+PrintReferenceGC -XX:+PrintAdaptiveSizePolicy -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=${BASE_PATH}/heapdump/bcserver.hprof"


JRE_HOME="$BASE_PATH/jre"
if [ $JRE_HOME ]; then
	JAVA_RUN=$JRE_HOME/bin/java
else
	echo "JRE_HOME environment variable not available."
    JAVA_RUN=`which java 2>/dev/null`
fi

if [ -z $JAVA_RUN ]; then
    echo "Java could not be found in your system."
    exit 1
fi

CLASSPATH="${BASE_PATH}/lib/*:${BASE_PATH}/bluecardinal-core.jar"


echo "########################################"
#echo "# JAVA=$JAVA"
#echo "# JAVA_OPTS=$JAVA_OPTS"
#echo "# CLASSPATH=$CLASSPATH"
echo "Well Operational Operator is initialized"
echo "########################################"
echo $JAVA_RUN $JAVA_OPTION -cp $CLASSPATH:$JAR_FILE com.sigmastream.main.Main -b=${BASE_PATH}/ -c=$CONFIG_FILES -groupid=$GROUP_ID -hzd $@

export JAVA_OPTION
export CLASSPATH
export JAR_FILE
export BASE_PATH
export CONFIG_FILES
export GROUP_ID
export JAVA

$JAVA_RUN $JAVA_OPTION -cp $CLASSPATH:$JAR_FILE com.sigmastream.main.Main -b=${BASE_PATH}/ -c=$CONFIG_FILES -groupid=$GROUP_ID -hzd $@
