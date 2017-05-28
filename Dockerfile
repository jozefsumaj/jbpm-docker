#################################################################################
# Dockerfile that provides the image for JBoss jBPM Workbench 6.5.0.Final Showcase
#################################################################################

####### BASE ############
FROM jboss/jbpm-workbench:6.5.0.Final-1

####### MAINTAINER ############
MAINTAINER "Jozef Sumaj" "jozef.sumaj@gmail.com"

####### ENVIRONMENT ############
# Use demo and examples by default in this showcase image (internet connection required).
ENV KIE_DEMO false
ENV KIE_SERVER_PROFILE standalone-full-jbpm
ENV JAVA_OPTS -Xmx2g

####### jBPM Workbench CUSTOM CONFIGURATION ############
ADD etc/standalone-full-jbpm.xml $JBOSS_HOME/standalone/configuration/standalone-full-jbpm.xml
ADD etc/jbpm-users.properties $JBOSS_HOME/standalone/configuration/jbpm-users.properties
ADD etc/jbpm-roles.properties $JBOSS_HOME/standalone/configuration/jbpm-roles.properties

# Added files are chowned to root user, change it to the jboss one.
USER root
RUN chown jboss:jboss $JBOSS_HOME/standalone/configuration/standalone-full-jbpm.xml && \
chown jboss:jboss $JBOSS_HOME/standalone/configuration/jbpm-users.properties && \ 
chown jboss:jboss $JBOSS_HOME/standalone/configuration/jbpm-roles.properties

# Switchback to jboss user
USER jboss

####### RUNNING JBPM-WB ############
WORKDIR $JBOSS_HOME/bin/
CMD ["./start_jbpm-wb.sh"]