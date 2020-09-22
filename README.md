# wls-oci-migration-toolkit
Migration Tool Kit for migrating on-prem workloads to OCI 

Please follow the steps in the same order

 1. Download weblogic-deploy.zip from https://github.com/oracle/weblogic-deploy-tooling/releases/tag/release-1.9.5 on the server running the migraton tool

 2. Download JDK from https://www.oracle.com/in/java/technologies/javase/javase-jdk8-downloads.html on the server running the migration tool

 3. git clone https://github.com/shashirsb/wls-oci-migration-toolkit.git

 4. After cloninig run "cd wls-oci-migration-toolkit; ./setup.sh"

 5. Edit "wls-oci-migration-toolkit/core-k8s-scripts/env.sh" to add docker registry and oracle container registry login credentials

run "migtool" to start the CLI.



