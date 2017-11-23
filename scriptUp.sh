response=null


while [ $response != 1 ] || [ $response != 2 ]
do
    echo "Bonjour, nous allons vous telecharger VirtualBox et Vagrant.
    Tapez 1 pour continuer
    Tapez 2 pour annuler le script
    Tapez 3 pour sauter cette etape."

    read response

    if [ $response = 1 ]
    then
        sudo apt install virtualbox-qt -y
        sudo apt install vagrant -y
    elif [ $response = 2 ]
        then
            break
    elif [ $response = 3 ]
    then
        echo -e "\033[32mVous passez a la suite.\033[0m "
    else
        echo -e "\033[31mCommande non connue\033[0m "
    fi

    echo "Nous vous proposons de vous creer votre VM
    Tapez 1 pour continuer
    Tapez 2 pour annuler le script
    Tapez 3 pour sauter cette etape."

    read response

    if [ $response = 1 ]
    then
        echo "Quel box voulez vous installer ?
        Tapez 1  pour xenial64
        Tapez 2 pour trusty64."
        read box

        if [ $box = 1 ]
        then
            box=xenial64
        elif [ $box = 2 ]
        then
            box=trusty64
        else [[ $box = 'xenial64' || 'trusty64' ]]
            echo -e "\033[31mCommande non connue\033[0m "
        fi

        echo "Quel dossier voulez vous créer afin de faire la synchronisation sur la machine hote ?"
        read dossierHote

        echo "Quel dossier voulez vous créer afin de faire la synchronisation sur la machine virtuel ? Veuillez commencer par un /, exemple /var/www/html"
        read dossierVirtuel

        mkdir $dossierHote

        echo "
        # -*- mode: ruby -*-
        # vi: set ft=ruby :
        Vagrant.configure(2) do |config|
        config.vm.box = 'ubuntu/"$box"'
        config.vm.network 'private_network', ip: '192.168.33.10'
        config.vm.synced_folder './"$dossierHote"', '"$dossierVirtuel"'
        end" > Vagrantfile
    elif [ $response = 2 ]
        then
            break
    elif [ $response = 3 ]
    then
        echo -e "\033[32mVous passez a la suite.\033[0m "
    else
        echo -e "\033[31mCommande non connue\033[0m "
    fi

    echo "Maintenant plusieurs choix s'offre a vous.
    Tapez 1 pour demarrer votre VM et vous connecter en SSH
    Tapez 2 pour afficher toute les vagrants existantes
    Tapez 3 pour interagir avec une vagrant
    Tapez 4 pour annuler le script."

    read response

    if [ $response = 1 ]
    then
        vagrant up
        vagrant ssh
    elif [ $response = 2 ]
    then
        vagrant global-status
    elif [ $response = 3 ]
    then
        echo "Que voulez vous faire ?
        Tapez 1 pour arreter une VM
        Tapez 2 pour supprimer une VM
        Tapez 3 pour arreter le script"
        read response
        if [ $response = 1 ]
        then
            vagrant global-status
            echo "Vous pouvez voir un tableau ci-dessus avec les differentes VM existante sur votre ordinateur.
            Vous y trouverez tout a gauche l'id de la VM,
            Tapez l'id de la VM pour l'arreter."
            read vm
            vagrant halt $vm
            echo -e "\033[32mVM arretee.\033[0m "
        elif [ $response = 2 ]
        then
            vagrant global-status
            echo "Vous pouvez voir un tableau ci-dessus avec les differentes VM existante sur votre ordinateur.
            Vous y trouverez tout a gauche l'id de la VM,
            Tapez l'id de la VM pour la supprimer."
            read vm
            vagrant destroy -f $vm
            echo -e "\033[32mVM detruite.\033[0m "
        elif [ $response = 3 ]
        then
            break
        else
            echo -e "\033[31mCommande non connue\033[0m "
        fi
    elif [ $response = 4 ]
    then
        break
    else
        echo -e "\033[31mCommande non connue\033[0m "
    fi
done