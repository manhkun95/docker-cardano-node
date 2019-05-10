FROM ubuntu:18.04

RUN apt-get update &&\
    apt-get install -y git curl bzip2 &&\
    useradd -ms /bin/bash cardano &&\
    mkdir -m 0755 /nix &&\
    chown cardano /nix &&\
    mkdir -p /etc/nix &&\
    echo substituters = https://cache.nixos.org https://hydra.iohk.io > /etc/nix/nix.conf &&\
    echo trusted-substituters = >> /etc/nix/nix.conf &&\
    echo trusted-public-keys  = hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ= cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= >> /etc/nix/nix.conf &&\
    echo 'sandbox = false' >> /etc/nix/nix.conf &&\
    su - cardano -c 'git clone https://github.com/input-output-hk/cardano-sl.git /home/cardano/cardano-sl'

CMD /bin/bash -l
USER cardano
ENV USER cardano

RUN curl https://nixos.org/nix/install | sh

WORKDIR /home/cardano/cardano-sl
RUN git checkout master

RUN . /home/cardano/.nix-profile/etc/profile.d/nix.sh &&\
   nix-build -A connectScripts.testnet.explorer -o connect-explorer-to-testnet

EXPOSE 8100
CMD ./connect-explorer-to-testnet