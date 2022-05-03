{ config, lib, pkgs, ... }:

{
  imports = [ <home-manager/nix-darwin> ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [];

  environment.variables.EDITOR = "vi";

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  nixpkgs.config = {
    allowUnfree = true;
  };

  users.users.ssl = {
    name = "ssl";
    home = "/Users/ssl";
  };

  home-manager.users.ssl = { ... }: {
    home.packages = [
      pkgs.atool
      pkgs.bat
      pkgs.coursier
      pkgs.fd
      pkgs.fzf
      pkgs.htop
      pkgs.httpie
      pkgs.neovim
      pkgs.ngrok
      pkgs.oh-my-zsh
      pkgs.ripgrep
      pkgs.tmux
      pkgs.zsh
      pkgs.zsh-fast-syntax-highlighting
      pkgs.zsh-powerlevel10k
    ];

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    programs.zsh = {
      enable = true;
      profileExtra = ''
        eval "$(/opt/homebrew/bin/brew shellenv)"

        export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

        # >>> coursier install directory >>>
        export PATH="$PATH:/Users/ssl/Library/Application Support/Coursier/bin"
        # <<< coursier install directory <<<

        # >>> JVM installed by coursier >>>
        export JAVA_HOME="/Users/ssl/Library/Caches/Coursier/arc/https/cdn.azul.com/zulu/bin/zulu17.32.13-ca-jdk17.0.2-macosx_aarch64.tar.gz/zulu17.32.13-ca-jdk17.0.2-macosx_aarch64"
        # <<< JVM installed by coursier <<<

        eval "$(frum init)"
      '';
      shellAliases = {
        vi = "nvim";
        vim = "nvim";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "fzf"
        ];
        theme = "robbyrussell";
      };
      plugins = [
        {
          name = "fast-syntax-highlighting";
          src = pkgs.zsh-fast-syntax-highlighting;
        }
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "powerlevel10k-config";
          src = lib.cleanSource ./p10k-config;
          file = "p10k.zsh";
        }
      ];
    };

  };
}
