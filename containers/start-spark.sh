#!/bin/bash

if [  "$HOSTNAME" == "sparkmaster" ]; then
   
    ${SPARK_HOME}/bin/spark-class org.apache.spark.deploy.master.Master --host ${HOSTNAME} --port ${SPARK_MASTER_PORT} --webui-port ${SPARK_MASTER_WEBUI_PORT}

else


    # whait master to start
    while [ ! nc -z ${HOSTNAME} ${SPARK_MASTER_PORT} ]; do
        sleep 2;
    done;
    
    ${SPARK_HOME}/bin/spark-class org.apache.spark.deploy.worker.Worker spark://${HOST_NAME_MASTER}:${SPARK_MASTER_PORT} --cores ${WORKER_CORES_DEFAULT} --memory ${WORKER_MEMORY_DEFAULT}

fi


