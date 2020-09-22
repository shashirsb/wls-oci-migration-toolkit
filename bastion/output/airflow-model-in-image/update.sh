export JAVA_HOME=/shared/bastion/jdk;
export BASTION_HOME=/shared/bastion;
/shared/bastion/weblogic-deploy/bin/updateDomain.sh  -oracle_home /u01/oracle -domain_home /shared/domains/pv-domain1 -archive_file /shared/airflow/airflow-onprem.zip -model_file /shared/airflow/airflow-onprem.yaml -variable_file /shared/airflow/airflow-onprem.properties -admin_url t3://pv-domain1-admin-server:7001;
