{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "razzkumars-tools";
      paths = [
        neovim
        go
        nodejs_22
        starship
        fd
        ripgrep
        fzf
        gh
        lazygit
        kubectl
        kubectx
        jq
        yq
        fish
        argocd
        krew
        tmux
      ];
    };
  };
}
