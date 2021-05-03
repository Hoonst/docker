for ((argpos=1; argpos<$#; argpos++)); do
   if [ "${!argpos}" == "--container_name" ]; then
      argpos_plus1=$((argpos+1))
      container_name=${!argpos_plus1}
   fi
   if [ "${!argpos}" == "--image_name" ]; then
      argpos_plus1=$((argpos+1))
      image_name=${!argpos_plus1}
   fi
done

echo "Container_name: " $container_name
echo "Image_name: " $image_name

docker run --gpus all -td --ipc=host --name $container_name\
	-v ~/gitRepo:/repo\
	-v /etc/passwd:/etc/passwd\
	-p 8890:8890 -p 6008:6008 $image_name
