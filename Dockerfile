FROM fedora:34

COPY files/repositories/* /etc/yum.repos.d/
COPY files/scripts/* /opt/
COPY files/certificates/* /opt/

RUN dnf upgrade -y
RUN dnf install git python bash bash-completion httpie kubectl terraform pwgen vim jq golang-github-aliyun-cli -y

# Configure bash-git-prompt
RUN git clone https://github.com/magicmonty/bash-git-prompt.git /root/.bash-git-prompt --depth=1
RUN cat /opt/bash-git-prompt.sh >> /root/.bashrc

# Configure kubectl completion
RUN cat /opt/kubectl-completion.sh >> /root/.bashrc

# Use vim instead of vi by default
RUN echo "alias vi='/bin/vim'"

# Trust root CA
RUN trust anchor /opt/root-ca-1.pem
RUN echo "export CURL_CA_BUNDLE=/opt/root-ca-1.crt" >> /root/.bashrc

# Due to corporate proxy it's necessary to ignore SSL for Git
RUN git config --global http.sslVerify false

CMD /bin/bash