#!/bin/bash

lsb_release -a

# --------------------------------------------------------------------------------
# 安装 openssh 配置基本信息
# --------------------------------------------------------------------------------
apt update
apt -y install openssh-server
apt -y autoremove
service ssh restart

cd ~/.ssh
rm -rf *
ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ""
mv id_rsa.pub authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDMhaSWcta4hSenjQA3ng5uGXJS0QKV/bC53AQZh95DbwKc79sOfLmHAxmAXS5sExOy+4yNLDg8RkSbGjV7YN5wR6CS8LSKzPFdv9iT0h2wtWZTym4I+xnK2blFDfLuhifD+Vj1nuzTGg1djmlOteKLcjHPphrQyzqRCAesNiVUeQDbOYvgrzhy2hVhf0PS3mEElVE4NPzZafEzhdyBMEmcWZUQ+ltsztvi8OFWy4OudiBcLSs9aJFErzZlNejKoV9OtsdVpjxMlXywzm0Mq1GS905XfJlBpo19tmPVG9K9//1RytcATX3z3r4n26NS7vgM960iWVA/0k3IgXHciKo9MvDzlUlTt7FJjGeYiHoz+lcRAoy6InR2bZIPjv7RSwPtdcY5xjZFHR+BhXbMGmTD3CEEf2OjiEo3Uv0Lye+LAs+AMnfcouIROqRPm328JwfOvqUlsWulDRSTo0UOnRD1ecal/sm6f9FWDGKtwXtyexlmkCSbl07wnlgIz2dyW0eQV+6PBLlmQAWuEYHABrCqqhbLxvZWxkwOCApgq1/0rdc4zDsnVHPK+DYZ/zHf3/E5LHHqh3JTChWAkvtJQo+SW4LGjMW6tZbYC9udNk0Ay2PDZfXVOyIc5wEf14YZQ7KJxdwzS9Hd6cu2UKybODC2OHb2vbiGElFaF3hF5ntQvQ== xuh@xhdev" >> authorized_keys
cat authorized_keys

# --------------------------------------------------------------------------------
# 基本环境 - alias
# --------------------------------------------------------------------------------
cd ~/
bashrc_file="tmp_bashrc"
echo "# `date`" > $bashrc_file
echo "alias egrep='egrep --color=auto'" >> $bashrc_file
echo "alias fgrep='fgrep --color=auto'" >> $bashrc_file
echo "alias grep='grep --color=auto'" >> $bashrc_file
echo "alias l.='ls -d .* --color=auto'" >> $bashrc_file
echo "alias ll='ls -l --color=auto'" >> $bashrc_file
echo "alias ls='ls --color=auto'" >> $bashrc_file
echo "alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'" >> $bashrc_file

cat $bashrc_file >> .bashrc
source ~/.bashrc

# 如果本地没有 java 环境，安装
java -version
if [ $? -ne 0 ]; then
    apt -y install default-jdk
fi

# 如果本地没有 groovy 环境，安装
groovy -version
groovy_version=3.0.21
if [ $? -ne 0 ]; then
    echo "install groovy"
    wget https://repo1.maven.org/maven2/org/codehaus/groovy/groovy-all/$groovy_version/groovy-all-$groovy_version.jar -O groovy-all-$groovy_version.jar
    mkdir -p /usr/local/groovy
    mv groovy-all-$groovy_version.jar /usr/local/groovy
    echo 'PATH=$PATH:/usr/local/groovy/bin' >> ~/.bashrc
    source ~/.bashrc
fi

# 如果本地没有 grails 环境，安装
grails -version
grails_version=6.2.0
if [ $? -ne 0 ]; then
    echo "install grails"
    wget https://github.com/grails/grails-core/releases/download/v$grails_version/grails-$grails_version.zip -O grails-$grails_version.zip
    unzip grails-$grails_version.zip
    mv grails-$grails_version /usr/local/grails
    echo 'PATH=$PATH:/usr/local/grails/bin' >> ~/.bashrc
    source ~/.bashrc
fi
