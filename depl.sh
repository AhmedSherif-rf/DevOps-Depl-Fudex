#!/bin/bash
if [ "$1" = "ahmedsherifmo/qvm-wallet" ]; then
    # Check if the argument is "ahmedsherifmo/qvm-wallet"
    echo "Removing the Container ahmedsherifmo/qvm-wallet ....."
    docker rm -f qvm-wallet qvm-admin-nginx
    
    echo "Removing the volume 'q_parts_qvm-wallet'..."
    docker volume rm devops-cicd-deploy_qvm-wallet
    
    echo "Removing the old image 'ahmedsherifmo/qvm-wallet' ...."
    docker rmi -f ahmedsherifmo/qvm-wallet
    
    echo "Deploying the New Wallet service version...."
    docker-compose -f /home/ec2-user/devops-cicd-deploy/docker-compose.yml up -d
    
    echo "Check for new table needs to be migrated"
    docker exec -it qvm-wallet php artisan migrate

elif [ "$1" = "ahmedsherifmo/qvm-notifications" ]; then
    echo "Removing the Container ahmedsherifmo/qvm-notifications....."
    docker rm -f qvm-notifications qvm-admin-nginx

    echo "Removing the volume 'q_parts_qvm-notifications'..."
    docker volume rm devops-cicd-deploy_qvm-notifications

    echo "Removing the old image 'ahmedsherifmo/qvm-notifications' ...."
    docker rmi -f ahmedsherifmo/qvm-notifications
    
    echo "Deploying the New Notification service version...."
    docker-compose -f /home/ec2-user/devops-cicd-deploy/docker-compose.yml up -d

    echo "Check for new table needs to be migrated"
    docker exec -it qvm-notifications php artisan migrate

elif [ "$1" = "ahmedsherifmo/qvm-order" ]; then
    echo "Removing the Container ahmedsherifmo/qvm-order ....."
    docker rm -f qvm-order qvm-admin-nginx

    echo "Removing the volume 'q_parts_qvm-order '..."
    docker volume rm devops-cicd-deploy_qvm-order

    echo "Removing the old image 'ahmedsherifmo/qvm-order' ...."
    docker rmi -f ahmedsherifmo/qvm-order
    
    echo "Deploying the New Order service version...."
    docker-compose -f /home/ec2-user/devops-cicd-deploy/docker-compose.yml up -d

    echo "Check for new table needs to be migrated"
    docker exec -it qvm-order php artisan migrate

elif [ "$1" = "ahmedsherifmo/erp-stock" ]; then
    echo "Removing the Container ahmedsherifmo/erp-stock ....."
    docker rm -f erp-stock qvm-admin-nginx

    echo "Removing the volume ' q_parts_erp-stock '..."
    docker volume rm devops-cicd-deploy_erp-stock

    echo "Removing the old image 'ahmedsherifmo/erp-stock' ...."
    docker rmi -f ahmedsherifmo/erp-stock

    echo "Deploying the New erp-stock service version...."
    docker-compose -f /home/ec2-user/devops-cicd-deploy/docker-compose.yml up -d
    
    echo "Check for new table needs to be migrated"
    docker exec -it erp-stock php artisan migrate

else
    image_name=$1

    # Get a list of all running containers based on the image name
    container_ids=$(docker ps --filter "ancestor=$image_name" -q)

    # Stop and remove the running containers
    for container_id in $container_ids; do
        echo "Stopping and removing container $container_id..."
        docker stop $container_id
        docker rm $container_id
    done

    # Remove the image
    echo "Removing image $image_name..."
    docker rmi $image_name

    echo "Cleanup complete."

    docker-compose -f /home/ec2-user/devops-cicd-deploy/docker-compose.yml up -d

fi

output=$(docker images -q -f dangling=true)
 
# Check if the output is not empty
if [ -n "$output" ]; then
    echo "There some old images and it would be deleted: $output"
    docker rmi $(docker images -q -f dangling=true)
else
    echo "There are no old versions of the images.... "
fi
