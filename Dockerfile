FROM ubuntu:latest
RUN apt-get update && apt-get install -y curl ca-certificates
RUN curl -fsSL https://clis.cloud.ibm.com/install/linux | sh
RUN ibmcloud plugin install power-iaas
RUN ibmcloud plugin update
COPY delete-private-subnet.sh /app/
WORKDIR /app
RUN chmod +x delete-private-subnet.sh 
CMD ["sh", "-c", "./delete-private-subnet.sh"]

