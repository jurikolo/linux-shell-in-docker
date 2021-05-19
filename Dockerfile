FROM fedora:34

COPY files/repositories/* /etc/yum.repos.d/
COPY files/scripts/* /opt/

RUN dnf upgrade -y
RUN dnf install git python bash bash-completion httpie kubectl terraform pwgen vim -y

# Configure bash-git-prompt
RUN git clone https://github.com/magicmonty/bash-git-prompt.git /root/.bash-git-prompt --depth=1
RUN cat /opt/bash-git-prompt.sh >> /root/.bashrc

# Configure kubectl completion
RUN cat /opt/kubectl-completion.sh >> /root/.bashrc

# Use vim instead of vi by default
RUN echo "alias vi='/bin/vim'"

CMD python3 /opt/sleep.py