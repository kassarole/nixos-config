{ config, pkgs, lib, ...}:
{
    home.username = "krode";
    home.homeDirectory = "/Users/krode";
    home.stateVersion = "25.05";
    programs.home-manager.enable = true;
    home.packages = with pkgs; [
        dockutil
    ];
    programs.git = {
        enable = true;
        userName = "kass";
        userEmail = "kass@basedzone.xyz";
    };
    programs.zsh = {
        enable = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        shellAliases = {
          update = "sudo darwin-rebuild switch --flake /Users/krode/Documents/nixos-config#nike";
          build = "sudo darwin-rebuild build --flake /Users/krode/Documents/nixos-config#nike";
    };
        oh-my-zsh = {
            enable = true;
            plugins = [ "git" ];
            theme = "half-life";
        };
    };
    home.file.".config/karabiner/karabiner.json".text = builtins.toJSON {
      global = {};
      profiles = [
        {
          name = "Default profile";
          selected = true;
          complex_modifications = {
            rules = [
              {
                description = "Cmd+D to Launchpad";
                manipulators = [
                  {
                    type = "basic";
                    from = {
                      key_code = "d";
                      modifiers = {
                        mandatory = [ "command" ];
                      };
                    };
                    to = [
                      {
                        key_code = "f4";
                      }
                    ];
                  }
                ];
              }
              {
                description = "Ctrl+Opt+t to Ghostty";
                manipulators = [
                  {
                    type = "basic";
                    from = {
                      key_code = "t";
                      modifiers = {
                        mandatory = [ "control" "option" ];
                      };
                    };
                    to = [
                      {
                        shell_command = "open -a Ghostty";
                      }
                    ];
                  }
                ];
              }              
            ];
          };
        }
      ];
    };

    home.activation.configureDock = lib.hm.dag.entryAfter ["writeBoundary"] ''
        # Clear and rebuild Dock
        ${pkgs.dockutil}/bin/dockutil --remove all --no-restart
        ${pkgs.dockutil}/bin/dockutil --add /System/Applications/Launchpad.app --no-restart
        ${pkgs.dockutil}/bin/dockutil --add /Applications/Microsoft\ Edge.app --no-restart
        ${pkgs.dockutil}/bin/dockutil --add /Applications/Ghostty.app --no-restart
        ${pkgs.dockutil}/bin/dockutil --add /Applications/Visual\ Studio\ Code.app --no-restart
        
        killall Dock || true
    '';
    home.file.".zshrc".text = lib.mkAfter ''
      export TERM=xterm-256color
    '';
}