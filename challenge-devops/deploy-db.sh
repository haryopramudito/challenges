#!/bin/bash
export BASE_PATH=`pwd`
export HELM_PATH=$BASE_PATH/helm
if [ -z "$1" ]
        then
        echo "#################################################"        
        echo "# please add environment argument !!            #"
        echo "# =================================             #"
        echo "# sh scriptname.sh dev or sh scriptname.sh prod #"
        echo "#################################################"
else
        export ENV=$1
        define_env()
        {
                export NAMESPACE=opn-$ENV
                #please specify your kubeconfig file in my case i use as below file
                export KUBECONFIG=~/.kube/config_$ENV
        }

        deploy_db()
        {
                cd $HELM_PATH/patroni
                if [ "$ENV" = "prod" ]; then
                        helm install -f values-$ENV.yaml -n $NAMESPACE my-patroni . 

                else
                        helm install -f values-$ENV.yaml -n $NAMESPACE my-patroni .
                fi
        }


        echo "define Environment Variables:"
        echo =================================
        define_env
        echo ""
        echo "Deploy DB Using Helm Chart"
        echo =================================
        deploy_db
fi

