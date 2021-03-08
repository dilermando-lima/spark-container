FROM openjdk:8


# installing spark
RUN apt-get update -y && \
    apt-get install -y curl && \
    wget -O spark.tgz https://archive.apache.org/dist/spark/spark-3.1.1/spark-3.1.1-bin-hadoop2.7.tgz && \
    tar -xf spark.tgz


RUN mkdir /usr/spark && mv /spark-3.1.1-bin-hadoop2.7/* /usr/spark && rm spark.tgz && rmdir spark-3.1.1-bin-hadoop2.7

# setting env vars
ENV WORKER_CORES_DEFAULT 2
ENV WORKER_MEMORY_DEFAULT 512M
ENV HOST_NAME_MASTER sparkmaster 
ENV SPARK_HOME /usr/spark 
ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER_WEBUI_PORT 8080
ENV SPARK_SUBMIT_API 6066
ENV SPARK_JOB_UI_PORT 4040


# Creating a enviroment var to use spark-shell
RUN echo "export SPARK_HOME=${SPARK_HOME}" >> /etc/bash.bashrc && echo "export PATH=$PATH:${SPARK_HOME}/bin" >> /etc/bash.bashrc
# Settings config

RUN echo "spark.master.rest.enabled true\n" >> ${SPARK_HOME}/conf/spark-defaults.conf  

ADD start-spark.sh start-spark.sh
RUN chmod +x start-spark.sh

EXPOSE ${SPARK_MASTER_WEBUI_PORT} ${SPARK_JOB_UI_PORT} ${SPARK_WEB_UI} ${SPARK_MASTER_PORT}

CMD ["bash","start-spark.sh"]






