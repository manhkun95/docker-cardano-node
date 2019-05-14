FROM nixos/nix

RUN nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
RUN nix-channel --update

RUN apk add --no-cache bash git &&\
    useradd -ms /bin/bash cardano &&\
    echo substituters = https://cache.nixos.org https://hydra.iohk.io >> /etc/nix/nix.conf &&\
    echo trusted-substituters = >> /etc/nix/nix.conf &&\
    echo trusted-public-keys  = hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ= cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= >> /etc/nix/nix.conf &&\
    git clone https://github.com/input-output-hk/cardano-sl.git /home/cardano/cardano-sl

USER cardano
WORKDIR /home/cardano/cardano-sl
RUN git checkout master

RUN sed -i "s|defaultPageSize = 10|defaultPageSize = 1 |g" explorer/src/Pos/Explorer/DB.hs
RUN nix-build -A connectScripts.testnet.explorer -o connect-explorer-to-testnet

EXPOSE 8100
CMD ./connect-explorer-to-testnet