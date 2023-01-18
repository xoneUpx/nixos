{ config, lib, pkgs, ... }:

let 
  modifier = "Mod4";
in 
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "bobok";
  home.homeDirectory = "/home/bobok";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  #home.stateVersion = "22.11";
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
	git
	vim
	];
  home.file = {
	".xinitrc".text = ''exec i3'';
	".bashrc".source = .dotfiles/bash/.bashrc;
	".config/init.vim".source = .dotfiles/nvim/.config/init.vim;
	".local/bin/.tmux-cht-command".source = .dotfiles/tmux/.tmux-cht-command;
	".local/bin/.tmux-cht-languages".source = .dotfiles/tmux/.tmux-cht-languages;
	".tmux.conf".source = .dotfiles/tmux/.tmux.conf;
	};

  xsession.enable = true;
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
#
#      fonts = ["DejaVu Sans Mono, FontAwesome 6"];
#
      keybindings = lib.mkOptionDefault {
#        "${modifier}+p" = "exec ${pkgs.dmenu}/bin/dmenu_run";
#        "${modifier}+x" = "exec sh -c '${pkgs.maim}/bin/maim -s | xclip -selection clipboard -t image/png'";
#        "${modifier}+Shift+x" = "exec sh -c '${pkgs.i3lock}/bin/i3lock -c 222222 & sleep 5 && xset dpms force of'";
         #"Mod4+Return" = "exec xterm -bg black -fg white";
         "${modifier}+Return" = "exec xterm -bg black -fg white";

#
#        # Focus
#        "${modifier}+j" = "focus left";
#        "${modifier}+k" = "focus down";
#        "${modifier}+l" = "focus up";
#        "${modifier}+semicolon" = "focus right";
#
#        # Move
#        "${modifier}+Shift+j" = "move left";
#        "${modifier}+Shift+k" = "move down";
#        "${modifier}+Shift+l" = "move up";
#        "${modifier}+Shift+semicolon" = "move right";
#
#        # My multi monitor setup
#        "${modifier}+m" = "move workspace to output DP-2";
#        "${modifier}+Shift+m" = "move workspace to output DP-5";
      };

      #bars = [
     #		   {
     # 	    position = "bottom";
     #  	   statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${./i3status-rust.toml}";
     #   	}
     # 	];
    };
  };

}
