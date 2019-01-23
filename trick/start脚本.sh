#!/bin/env sh
hosts="master slave1 slave2"
function start_storm(){
    #Start the zookeeper
    start_zk
    for host in ${hosts}; do
        #Start the storm
        if [ "$host" == "master" ]; then
           # 利用storm本身的命令启动master节点的 nimbus ui logview 进程
           ssh master "python /usr/local/src/apache-storm-0.9.3/bin/storm nimbus > /dev/null 2>&1 &"
           ssh master "python /usr/local/src/apache-storm-0.9.3/bin/storm ui >  /dev/null 2>&1 &"
           ssh master "python /usr/local/src/apache-storm-0.9.3/bin/storm logviewer > /dev/null 2>&1 &"
        fi

        if [ "$host" == "slave1" ]; then
           # 利用storm本身的命令启动slave1节点的 supervisor logview 进程
           ssh slave1 "python /usr/local/src/apache-storm-0.9.3/bin/storm supervisor > /dev/null 2>&1 &"
           ssh slave1 "python /usr/local/src/apache-storm-0.9.3/bin/storm logviewer > /dev/null 2>&1 &"
        fi

        if [ "$host" == "slave2" ]; then
           # 利用storm本身的命令启动slave2节点的 supervisor logview 进程
           ssh slave2 "python /usr/local/src/apache-storm-0.9.3/bin/storm supervisor > /dev/null 2>&1 &"
           ssh slave2 "python /usr/local/src/apache-storm-0.9.3/bin/storm logviewer > /dev/null 2>&1 &"
        fi

    done
}

function stop_storm(){
    #Stop the storm
    for host in ${hosts}; do
        echo "Stop success at [$host]"
        #远程到master slave1 slave2 节点找到storm有关进程 并kill掉 将执行的日志丢进黑洞 并在错误重定向到标准输出 且在后台执行
        ssh $host " ps aux| grep storm | grep -v 'grep' | grep -v 'storm.sh' | awk '{print $2}' | xargs kill -9  > /dev/null 2>&1 &"
    done
}

function start_hbase(){
    #Start the hadoop
    start_hadoop
    #Start the zookeeper
    start_zk
    #使用python通过thrift访问hbase
    #echo "==========Start the thrift=========="
    #ssh master "/usr/local/src/hbase-1.4.5/bin/hbase-daemon.sh start thrift"
    echo "==========Start the hbase=========="
    ssh master "/usr/local/src/hbase-1.4.5/bin/start-hbase.sh"
}


function stop_hbase(){
    echo "==========Stop the hbase=========="
    ssh master "/usr/local/src/hbase-1.4.5/bin/stop-hbase.sh"
}



function start_hadoop(){
    echo "==========Start the hadoop=========="
    ssh master "/usr/local/src/hadoop-2.6.1/sbin/start-all.sh"
}

function stop_hadoop(){
    echo "==========Stop the hadoop=========="
    ssh master "/usr/local/src/hadoop-2.6.1/sbin/stop-all.sh"
}

function start_kafka(){
    #Start the zookeeper
    start_zk
    echo "==========Start the kafka=========="
    ssh master "/usr/local/src/kafka_2.11-0.10.2.1/bin/kafka-server-start.sh  \
        /usr/local/src/kafka_2.11-0.10.2.1/config/server.properties "
}

function start_spark(){
    echo "==========Start the spark=========="
    ssh master "/usr/local/src/spark-2.0.2-bin-hadoop2.6/sbin/start-all.sh"
}

function stop_spark(){
    echo "==========Stop the spark=========="
    ssh master "/usr/local/src/spark-2.0.2-bin-hadoop2.6/sbin/stop-all.sh"
}


function start_hive(){
    #Start the hadoop
    start_hadoop
    echo "==========Start the mysql=========="
    ssh master "systemctl start mariadb"

    #echo "==========Stop the mysql=========="
    #ssh master "systemctl stop mariadb"
}


function start_zk(){
    echo "==========Start the zookeeper=========="
    for host in ${hosts}; do
        ssh $host "/usr/local/src/zookeeper-3.4.10/bin/zkServer.sh start"
    done
}

function stop_zk(){
    echo "==========Stop the zookeeper=========="
    for host in ${hosts}; do
        ssh $host "/usr/local/src/zookeeper-3.4.10/bin/zkServer.sh stop "
    done
}

function start_flink(){
    echo "==========Start the flink=========="
    for host in ${hosts}; do
        ssh $host "/usr/local/src/flink-1.4.0/bin/start-cluster.sh "
    done
}

function stop_flink(){
    echo "==========Stop the flink=========="
    for host in ${hosts}; do
        ssh $host "/usr/local/src/flink-1.4.0/bin/stop-cluster.sh "
    done
}

case "$1" in
    start_storm)
        start_storm
        ;;
    stop_storm)
        stop_storm
        ;;
    start_hbase)
        start_hbase
        ;;
    stop_hbase)
        stop_hbase
        ;;
    start_hadoop)
        start_hadoop
        ;;
    stop_hadoop)
        stop_hadoop
        ;;
    start_kafka)
        start_kafka
        ;;
    start_spark)
        start_spark
        ;;
    stop_spark)
        stop_spark
        ;;
    start_hive)
        start_hive
        ;;
    start_zk)
        start_zk
        ;;
    stop_zk)
        stop_zk
        ;;
    start_flink)
        start_flink
        ;;
    stop_flink)
        stop_flink
        ;;
    *)
        echo "The parameter is illegal, please enter{start|status|stop}"
        ;;
esac