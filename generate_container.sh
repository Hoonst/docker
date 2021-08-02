for ((argpos=1; argpos<$#; argpos++)); do
   if [ "${!argpos}" == "--container_name" ]; then
      argpos_plus1=$((argpos+1))
      container_name=${!argpos_plus1}
   fi
   if [ "${!argpos}" == "--image_name" ]; then
      argpos_plus1=$((argpos+1))
      image_name=${!argpos_plus1}
   fi
   if [ "${!argpos}" == "--port1" ]; then
      argpos_plus1=$((argpos+1))
      port1=${!argpos_plus1}
   fi
   if [ "${!argpos}" == "--port2" ]; then
      argpos_plus1=$((argpos+1))
      port2=${!argpos_plus1}
   fi
done

echo "Container_name: " $container_name
echo "Image_name: " $image_name
echo "Port1: " $port1
echo "Port2: " $port2

docker run --gpus all -td --ipc=host --name $container_name\
	-v ~/gitRepo:/repo\
	-v /etc/passwd:/etc/passwd\
	-p $port1:$port1 -p $port2:$port2 $image_name
