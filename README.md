# wls-oci-migration-toolkit
Migration Tool Kit for migrating on-prem workloads to OCI 

Please follow the steps in the same order

 1. Download weblogic-deploy.zip from https://github.com/oracle/weblogic-deploy-tooling/releases/latest

 2. Download JDK from https://www.oracle.com/in/java/technologies/javase/javase-jdk8-downloads.html 

 3. git clone https://github.com/shashirsb/wls-oci-migration-toolkit.git under user home, e.g. /home/opc

 4. After cloninig run "cd wls-oci-migration-toolkit; ./setup.sh" and follow the instructions

 5. Edit "wls-oci-migration-toolkit/core-k8s-scripts/env.sh" to add docker registry and oracle container registry login credentials

run "migtool" to start the CLI.


What it can do:

1. Create weblogic domain on OKE
2. Create docker image with custom domain
3. Automate Updating on-prem domain resource to OKE - online
4. Automate process of discovering on-prem domain and converting into WDT files
5. Other options coming soon...

