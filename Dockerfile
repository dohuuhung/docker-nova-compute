FROM dohuuhung1234/openstack:base-pike
MAINTAINER dohuuhung "dohuuhung1234@gmail.com"
# install packages
#RUN apt-get -y install python-glanceclient python-keystoneclient python-novaclient
#RUN apt-get -y install nova-compute nova-network nova-api-metadata
RUN apt-get install software-properties-common -y
RUN apt-get update -y
RUN add-apt-repository cloud-archive:pike -y
RUN apt-get install -y python-mysqldb
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nova-compute

# remove the SQLite database file
RUN rm -f /var/lib/nova/nova.sqlite

EXPOSE 8774 67

#copy nova config file
COPY nova.conf /etc/nova/nova.conf

# add bootstrap script and make it executable
COPY bootstrap.sh /etc/bootstrap.sh
RUN chown root.root /etc/bootstrap.sh
RUN chmod 744 /etc/bootstrap.sh

ENTRYPOINT ["/etc/bootstrap.sh"]
