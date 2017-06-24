#!/bin/sh	
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
echo " for any query .. connect to vishalyadav.hbti@gmail.com "
/bin/sleep 3
read -p " hi $USER Start to Download Kafka Continue (y/n)? or configure manually(say (N))" choice
case "$choice" in 
  y|Y ) wget http://redrockdigimark.com/apachemirror/kafka/0.10.1.0/kafka_2.10-0.10.1.0.tgz 
	/bin/sleep 2
	echo "unziping file"	
	tar -xzf kafka_2.10-0.10.1.0.tgz
	/bin/sleep 2
	echo "removing zip file"
	rm kafka_2.10-0.10.1.0.tgz;;
  n|N ) echo " "$USER", Enter path of downloaded kafka dir: example /home/$USER/Downloads/kafka_2.10-0.10.1.0"
	read text
	cd ;;
  * ) echo "invalid Command"
      /bin/sleep 2      
      exit 1;;
esac
#exit 1
JAVA_VER=$(java -version 2>&1 | grep -i version | sed 's/.*version ".*\.\(.*\)\..*"/\1/; 1q')

if test $JAVA_VER -ne 8
then
    echo "please update your java packages we need java 1.8. Kafka will more stable with it"
else
    echo "$ ${green}\n\n Java version:$JAVA_VER is found"
fi
#exit 1
#cd $text
/bin/sleep 3

xterm -title "Zookeeper Server" -hold -e kafka_2.10-0.10.1.0/bin/zookeeper-server-start.sh kafka_2.10-0.10.1.0/config/zookeeper.properties  &
/bin/sleep 2
xterm -title "Kafka Server" -hold -e kafka_2.10-0.10.1.0/bin/kafka-server-start.sh kafka_2.10-0.10.1.0/config/server.properties  &

/bin/sleep 3
SERVICE='QuorumPeerMain'
if ps ax | grep -v grep | grep $SERVICE > /dev/null
then
    echo "\n\n${green}Zookeeper\t service running"
else
    echo "${red} $SERVICE(Zookeeper) is not running"
   
fi

/bin/sleep 5 

SERVICE1='Kafka'
if ps ax | grep -v grep | grep $SERVICE1 > /dev/null
then
    echo "${green} $SERVICE1\t\t\t service running, \n\tEverything is fine "
else
    echo "${red} $SERVICE1 is not running"
   
fi

/bin/sleep 3

case "$choice" in 
  y|Y ) echo "OK";;
  n|N ) exit 1 ;;
  * ) echo "invalid Command"
      /bin/sleep 2      
      exit 1;;
esac

read -p " hi $USER Want to Start app, producer and Consumer. Continue (y/n)? " choice

case "$choice" in 
  y|Y ) echo "ok"  ;;
  n|N ) exit 1;;
  * ) echo "invalid";;
esac

echo " "$USER", Enter path of app.js file dir: example /home/$USER/Downloads/passtheapi"
read txt
cd $txt
xterm -title "App.js" -hold -e node app.js &
/bin/sleep 5 
xterm -title "TaskServer" -hold -e node taskServer/taskServer.js   &
/bin/sleep 5 
xterm -title "Worker" -hold -e node workers/woker1.js worker1  &

echo " for any query .. connect to vishalyadav.hbti@gmail.com "
/bin/sleep 3
read -p "hi $USER Want to Exit  (y/n)?" choice
case "$choice" in 
  y|Y ) exit 1 ;;
  n|N ) echo "ok";;
  * ) echo "invalid";;
esac

