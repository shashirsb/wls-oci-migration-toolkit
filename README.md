# wls-oci-migration-toolkit
Migration Tool Kit for migrating on-prem workloads to OCI 

Please follow the steps in the same order ( step 1-3 should be on the same machine)

 1. Download weblogic-deploy.zip from https://github.com/oracle/weblogic-deploy-tooling/releases/latest

 2. Download JDK from https://www.oracle.com/in/java/technologies/javase/javase-jdk8-downloads.html

 3. git clone https://github.com/shashirsb/wls-oci-migration-toolkit.git

 4. After cloninig run "cd wls-oci-migration-toolkit; ./setup.sh"

 5. Edit "wls-oci-migration-toolkit/core-k8s-scripts/env.sh" to add docker registry and oracle container registry login credentials

run "migtool" to start the CLI.



