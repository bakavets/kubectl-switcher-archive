#!/bin/bash

echo "===================== Started! =========================="
echo "List of the Kubernetes contexts"
echo "========================================================="
i=1
for var in $(kubectl config get-contexts -o name)
do
  echo $i "-" $var
  i=$(($i+1))
  array+=($var)
done

echo "========================================================="
read -p "Select the context you want to work with. Your choice must be between 1 and ${#array[*]}: " varname

echo kubectl was configured to interact with context: ${array[$varname]}


