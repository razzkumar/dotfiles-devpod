{
  description = "devPod";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: let
    systemPackages = pkgs: pkgs.buildEnv {
      name = "razzkumars-tools";
      paths = with pkgs; [
        neovim
        go
        nodejs_18
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
        fluxcd
      ];
    };
  in {
    packages.x86_64-linux = systemPackages nixpkgs.legacyPackages.x86_64-linux;
    packages.aarch64-darwin = systemPackages nixpkgs.legacyPackages.aarch64-darwin;
  };
}
