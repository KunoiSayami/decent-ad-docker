FROM archlinux:latest

ARG REMOTE_ADDRESS

RUN echo -n -e '\n[kunoisayami]\nServer = ' >> /etc/pacman.conf

RUN echo ${REMOTE_ADDRESS} >> /etc/pacman.conf

RUN pacman-key --init

RUN curl -fL https://keys.openpgp.org/vks/v1/by-fingerprint/4A0F0C8BC709ACA4341767FB243975C8DB9656B9 | pacman-key --add -

RUN pacman-key --finger 4A0F0C8BC709ACA4341767FB243975C8DB9656B9

RUN pacman-key --lsign-key 4A0F0C8BC709ACA4341767FB243975C8DB9656B9

RUN useradd -m build

COPY hook.sh init-nvm.sh /home/build/

RUN  /home/build/hook.sh

RUN pacman --noconfirm --needed -Sy archlinux-keyring

RUN pacman --noconfirm --needed -Su base-devel gnupg git deno yay wget npm rustup

RUN echo 'build ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers

RUN npm i snarkjs -g

USER build

RUN yay --noconfirm --needed -S nvm

RUN /home/build/init-nvm.sh

RUN rustup install stable

RUN cargo install --git https://github.com/iden3/circom.git

RUN git clone --recursive https://github.com/EtaoinWu/DecentAd.git /home/build/decent

RUN echo 'export PATH=$HOME/.cargo/bin:$PATH' > /home/build/.bashrc

RUN echo 'source /usr/share/nvm/init-nvm.sh' >> /home/build/.bashrc

COPY build.sh /home/build/

RUN /home/build/build.sh

RUN /home/build/build.sh test

ENTRYPOINT ["bash"]
# ENTRYPOINT ["bash", "-c", "/home/build/repos/utils/pkgbuild_bootstap"]

#ENTRYPOINT ["bash"]

