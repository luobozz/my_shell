#!/bin/bash
# 该脚本适用从dockerfile创建镜像然后启动
# 切换成任意镜像名称就行
name='mira'
imagesName="$name"_images

echo "\n========EXISTS CHECKING============="
exitContainer=`sudo docker ps -aqf name=$name`
exitImages=`sudo docker images -q $imagesName`
if [ "$exitContainer" != "" ]; then
    echo "container [$name $exitContainer] is exists"
    sudo docker rm -f $name
    echo "remove container [$name $exitContainer] success\n"
else
    echo "container [$name] is clear"
fi
if [ "$exitImages" != "" ]; then
    echo "images [$imagesName $exitImages] is exists"
    sudo docker rmi -f $imagesName
    echo "remove images [$imagesName $exitImages] success"
else
    echo "images [$imagesName] is clear"
fi
echo "====================================\n"

sudo docker build -t $imagesName ./
echo "\n"
sudo docker images
echo "\n"

# sudo docker run -d --name=$name $imagesName tail -f /dev/null
sudo docker run -it --name=$name $imagesName /bin/bash
echo "\n"
sudo docker ps -a
echo "\n"