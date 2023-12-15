#!/bin/bash

# Waiting time for application to be deployed on k8s cluster by argocd
sleep 5s

# PORT=$(kubectl -n default get svc ${serviceName} -o json | jq .spec.ports[].nodePort)
# PORT=80

# echo $PORT
echo $applicationURL/$applicationURI

# if [[ ! -z "$PORT" ]];
# then

    response=$(curl $applicationURL$applicationURI)
    http_code=$(curl -o /dev/null -w "%{http_code}" $applicationURL$applicationURI)

    echo $response
    echo $http_code

    if [[ "$response" == "Smaller than or equal to 50" ]];
        then
            echo "Increment Test Passed"
        else
            echo "Increment Test Failed"
            exit 1;
    fi;

    if [[ "$http_code" == 200 ]];
        then
            echo "HTTP Status Code Test Passed"
        else
            echo "HTTP Status code is not 200"
            exit 1;
    fi;

# else
#         echo "The Service does not have a NodePort"
#         exit 1;
# fi;
