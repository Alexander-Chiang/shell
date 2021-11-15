#! /bin/bash

# Color
red='\033[31m'
green='\033[32m'
yellow='\033[33m'
plain='\033[0m'

hasJdk(){
    java -version
    if [ $? -eq 0 ]
    then
        return 1;
    else
        return 0;
    fi
}

hasJdk
if [ $? != 1 ]
then
    echo Download Oracle JDk1.8
    yum install -y wget 
    wget https://repo.huaweicloud.com/java/jdk/8u201-b09/jdk-8u201-linux-x64.tar.gz
    tar -zvxf jdk-8u201-linux-x64.tar.gz -C /usr/local && rm -f jdk-8u201-linux-x64.tar.gz
    
    cat > /etc/profile.d/oraclejdk.sh << \EOF
#!/bin/bash

export JAVA_HOME=/usr/local/jdk1.8.0_201
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
EOF

    source /etc/profile.d/oraclejdk.sh 

    hasJdk
    if [ $? == 1 ]
    then
        echo -e "${yellow}============================================================${plain}"
        echo -e "${green}JDK1.8 Install Success${plain}"
        echo -e "${yellow}============================================================${plain}"
    else
        echo -e "${yellow}============================================================${plain}"
        echo -e "${red}JDK1.8 Install Failed ${plain}"
        echo -e "${yellow}============================================================${plain}"
    fi
else
    echo -e "${green}JDK1.8 Exists Already${plain}"

fi
echo ""
