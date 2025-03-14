# Utiliser une image Ubuntu comme base
FROM ubuntu:20.04

# Éviter les interactions pendant l'installation
ENV DEBIAN_FRONTEND=noninteractive

# Mettre à jour et installer vsftpd et les outils nécessaires
RUN apt-get update && apt-get install -y \
    vsftpd \
    && rm -rf /var/lib/apt/lists/*

# Créer les groupes CSI et LIA
RUN groupadd CSI && groupadd LIA

# Créer les utilisateurs et les associer aux groupes
RUN useradd -m -G CSI user1 && echo "user1:password1" | chpasswd \
    && useradd -m -G CSI user2 && echo "user2:password2" | chpasswd \
    && useradd -m -G LIA user3 && echo "user3:password3" | chpasswd

# Créer les dossiers communs en root et ajouter un fichier dans chacun
RUN mkdir /CSI /LIA \
    && echo "Fichier test pour CSI" > /CSI/test_csi.txt \
    && echo "Fichier test pour LIA" > /LIA/test_lia.txt

# Définir les permissions des dossiers
RUN chown root:CSI /CSI && chmod 770 /CSI \
    && chown root:LIA /LIA && chmod 770 /LIA

# Copier le fichier de configuration vsftpd
COPY vsftpd.conf /etc/vsftpd.conf

# Exposer le port FTP
EXPOSE 21

# Démarrer le service vsftpd
CMD ["vsftpd", "/etc/vsftpd.conf"]