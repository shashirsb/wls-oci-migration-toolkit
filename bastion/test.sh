#!/bin/sh -x

IP="130.61.94.234 130.61.224.94"
        values=(130.61.94.234 130.61.224.94)
        walletlocation=/home/opc/Wallet_AE
        for i in "${values[@]}"; do
          echo "$i";
          scp -r $walletlocation opc@$i:/home/opc;
          ssh opc@$i ' hostname && sudo rm -rf /u01/migration &&  sudo mkdir /u01/migration && sudo mv /home/opc/Wallet_AE /u01/migration/ &&  sudo chown -R oracle:oracle /u01/migration  && hostname'
          hostname
        done

