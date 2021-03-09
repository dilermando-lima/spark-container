FROM openjdk:8


# installing spark
RUN apt-get update -y && \
    apt-get install -y curl && \
    wget -O spark.tgz https://archive.apache.org/dist/spark/spark-3.1.1/spark-3.1.1-bin-hadoop2.7.tgz && \
    tar -xf spark.tgz


RUN mkdir /usr/spark && mv /spark-3.1.1-bin-hadoop2.7/* /usr/spark && rm spark.tgz && rmdir spark-3.1.1-bin-hadoop2.7

# setting env vars
ENV SPARK_HOME /usr/spark 

# Creating a enviroment var to use spark-shell
RUN echo "export SPARK_HOME=${SPARK_HOME}" >> /etc/bash.bashrc && echo "export PATH=$PATH:${SPARK_HOME}/bin" >> /etc/bash.bashrc

# Settings config
RUN echo "spark.master.rest.enabled true\n" >> ${SPARK_HOME}/conf/spark-defaults.conf  

EXPOSE 7077 8080 6066 4040

CMD ${SPARK_HOME}/bin/spark-class org.apache.spark.deploy.master.Master --host ${HOSTNAME}






