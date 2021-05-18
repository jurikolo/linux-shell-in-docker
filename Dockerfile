FROM fedora:34

COPY repositories/* /etc/yum.repos.d/
COPY sleep.py .

RUN dnf upgrade -y
RUN dnf install python bash httpie kubectl terraform -y

CMD python3 sleep.py