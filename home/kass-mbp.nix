{ config, pkgs, ...}:
{
    home.username = "krode";
    home.homeDirectory = "/Users/krode";
    home.stateVersion = "25.05";
    programs.home-manager.enable = true;
    home.packages = with pkgs; [
    ];
    programs.git = {
        enable = true;
        userName = "kass";
        userEmail = "kass@basedzone.xyz";
    };
    programs.zsh = {
        enable = true;
        enableAutosuggestions = true;
        syntaxHighlighting.enable = true;
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

}