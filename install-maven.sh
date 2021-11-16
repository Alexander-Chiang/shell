#! /bin/bash

# Color
red='\033[31m'
green='\033[32m'
yellow='\033[33m'
plain='\033[0m'

exists(){
    mvn -version
    if [ $? -eq 0 ]
    then
        return 1;
    else
        return 0;
    fi
}

exists
if [ $? != 1 ]
then
    echo Download Maven
    yum install -y wget 
    wget https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.8.3/binaries//apache-maven-3.8.3-bin.tar.gz  --no-check-certificate
    tar -zxvf apache-maven-3.8.3-bin.tar.gz -C /usr/local -C /usr/local && rm -f apache-maven-3.8.3-bin.tar.gz
    
    cat > /etc/profile.d/maven.sh << \EOF
#!/bin/bash

export MAVEN_HOME=/usr/local/apache-maven-3.8.3
export PATH=$PATH:$MAVEN_HOME/bin
EOF

    source /etc/profile.d/maven.sh 

    exists
    if [ $? == 1 ]
    then
        echo -e "${yellow}============================================================${plain}"
        echo -e "${green}Maven Install Success${plain}"
        echo -e "${yellow}============================================================${plain}"
    else
        echo -e "${yellow}============================================================${plain}"
        echo -e "${red}Maven Install Failed ${plain}"
        echo -e "${yellow}============================================================${plain}"
    fi
else
    echo -e "${green}Maven Exists Already${plain}"

fi
echo ""
