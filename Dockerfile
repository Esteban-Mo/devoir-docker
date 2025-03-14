FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    vsftpd \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd CSI && groupadd LIA

RUN useradd -m -G CSI user1 && echo "user1:password1" | chpasswd \
    && useradd -m -G CSI user2 && echo "user2:password2" | chpasswd \
    && useradd -m -G LIA user3 && echo "user3:password3" | chpasswd

RUN mkdir /CSI /LIA \
    && echo "Fichier test pour CSI" > /CSI/test_csi.txt \
    && echo "Fichier test pour LIA" > /LIA/test_lia.txt

RUN chown root:CSI /CSI && chmod 770 /CSI \
    && chown root:LIA /LIA && chmod 770 /LIA

COPY vsftpd.conf /etc/vsftpd.conf

EXPOSE 21

CMD ["vsftpd", "/etc/vsftpd.conf"]