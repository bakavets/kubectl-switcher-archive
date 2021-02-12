#!/bin/bash

if [[ $1 = 'cc' ]];
then 
  echo Current context: $(kubectl config current-context)
elif [ -z $1 ]; # -z True if the length of string is zero.
then
  echo "=========================== Started ==========================="
  echo "List of the Kubernetes contexts:"
  echo "==============================================================="
  i=1
  for var in $(kubectl config get-contexts -o name)
  do
    echo $i "-" $var
    i=$(($i+1))
    array+=($var)
  done
  echo "==============================================================="
  read -p "Select the context you want to work with. Your choice must be between 1 and ${#array[*]}: " varname
  
  new_varname=$(($varname-1))
  kubectl config use-context ${array[$new_varname]}
  echo kubectl was configured to interact with context: $varname '-' ${array[$new_varname]}
elif [ $1 = 'ds' ]; # -z True if the length of string is zero.
then
  kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')
  echo "kubectl configured dashboard for context: $(kubectl config current-context)"
  kubectl proxy
else 
  echo "Run 'ksw --help' for usage"
fi

