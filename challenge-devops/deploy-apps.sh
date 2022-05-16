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

                deploy_apps()
        {
                cd $HELM_PATH/opn-devops
                if [ "$ENV" = "prod" ]; then
                         helm upgrade --install --atomic --timeout 30s --values values-$ENV.yaml $NAMESPACE opn-devops . 

                else
                        helm upgrade --install --atomic --timeout 2m0s --values values-$ENV.yaml --namespace  $NAMESPACE opn-devops . 
                fi
        }

        echo "define Environment Variables:"
        echo =================================
        define_env
        echo ""
        echo "Deploy Apps Using Helm Chart"
        echo =================================
        deploy_apps
fi

