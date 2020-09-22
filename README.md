# wls-oci-migration-toolkit
Migration Tool Kit for migrating on-prem workloads to OCI 

Step 1. Download weblogic-deploy.zip from https://github.com/oracle/weblogic-deploy-tooling/releases/tag/release-1.9.5 on the server running the migraton tool
Step 2. Download JDK from https://www.oracle.com/in/java/technologies/javase/javase-jdk8-downloads.html on the server running the migration tool
Step 3. Git clone 
Step 4. After cloninig run "cd wls-oci-migration-toolkit; ./setup.sh"
Step 5. Edit "wls-oci-migration-toolkit/core-k8s-scripts/env.sh" to add docker registry and oracle container registry login credentials

run "migtool" to start the CLI.



