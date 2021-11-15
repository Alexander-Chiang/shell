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
    echo "Not Found jdk"
    echo "Installing jdk..."
    yum install -y java-1.8.0-openjdk
    yum install -y java-1.8.0-openjdk-devel.x86_64
    echo "Set Environment variable..."
    
    cat > /etc/profile.d/openjdk.sh << \EOF
#!/bin/bash

export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.242.b08-0.el7_7.x86_64
export JRE_HOME=$JAVA_HOME/jre
export CLASSPATH=$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH
export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH
EOF

    source /etc/profile.d/openjdk.sh 

    hasJdk
    if [ $? == 1 ]
    then
        echo -e "${yellow}============================================================${plain}"
        echo -e "${green}JDK1.8 Install Success${plain}"
        echo -e "${yellow}============================================================${plain}"
    else
        echo -e "${yellow}============================================================${plain}"
        echo -e "${red}JDK1.8Install Failed ${plain}"
        echo -e "${yellow}============================================================${plain}"
    fi
else
    echo -e "${green}JDK1.8 Exists Already${plain}"

fi
echo ""