#! /bin/bash

hasJdk(){
    RESULT=$(pgrep java)
    if [[ ! $RESULT ]]
    then
        return 0;
    fi
    return 1;
}

hasJdk
if [ $? != 1 ]
then
    echo "Not Found jdk"
    echo "Installing jdk..."
    yum install -y java-1.8.0-openjdk
    yum install -y java-1.8.0-openjdk-devel.x86_64
    echo "Set Environment variable..."
    cat > /etc/profile.d/maven.sh << EOF
    #!/bin/bash

    export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.242.b08-0.el7_7.x86_64
    export JRE_HOME=$JAVA_HOME/jre
    export CLASSPATH=$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH
    export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH

    EOF
    source /etc/profile.d/maven.sh 
    
    hasJdk
    if [ $? != 1 ]
    then
      echo "Install jdk Fail"
    fi
fi

java -version
echo ""