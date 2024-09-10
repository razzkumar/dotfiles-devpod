{
  description = "devPod";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: let
    # Helper to define the system packages
    systemPackages = pkgs: pkgs.buildEnv {
      name = "razzkumars-tools";
      paths = with pkgs; [
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
  in {
    # Package definitions for different platforms
    packages = {
      x86_64-linux = systemPackages nixpkgs.legacyPackages.x86_64-linux;
      aarch64-darwin = systemPackages nixpkgs.legacyPackages.aarch64-darwin;
      x86_64-darwin = systemPackages nixpkgs.legacyPackages.x86_64-darwin;
    };

    # Default package for each platform
    defaultPackage = {
      x86_64-linux = self.packages.x86_64-linux;
      aarch64-darwin = self.packages.aarch64-darwin;
      x86_64-darwin = self.packages.x86_64-darwin;
    };

    # DevShell definitions for different platforms with Fish enabled
    devShells = {
      x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.mkShell {
        buildInputs = [ self.packages.x86_64-linux ];
        shellHook = ''
          exec fish
        '';
      };
      aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.mkShell {
        buildInputs = [ self.packages.aarch64-darwin ];
        shellHook = ''
          exec fish
        '';
      };
      x86_64-darwin = nixpkgs.legacyPackages.x86_64-darwin.mkShell {
        buildInputs = [ self.packages.x86_64-darwin ];
        shellHook = ''
          exec fish
        '';
      };
    };
  };
}
