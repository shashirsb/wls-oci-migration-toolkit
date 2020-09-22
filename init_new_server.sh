scp $HOME/wls-oci-migration-toolkit/* opc@$1:/home/opc
scp -r $HOME/.docker opc@$1:/home/opc
ssh opc@$1
