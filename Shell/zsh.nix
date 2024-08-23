{config, pkgs, ...}: 

let
	plugin_path = ".zsh_plugins";
in {
	# Allow z-jump a smarter cd 
	programs.zoxide = {
		enable = true;
	  enableZshIntegration = true	;
	};

	home.packages = with pkgs; [
		zsh-vi-mode
	  zsh-autosuggestions
	];
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;
		plugins = [
			{
				name = "zsh-vi-mode";
				src = pkgs.zsh-vi-mode;
				file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
			}

			{
				name = "zsh-autosuggestions";
				src = pkgs.zsh-vi-mode;
				file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
			}
		];

		initExtra = ''
			ZVM_VI_INSERT_ESCAPE_BINDKEY=jj
		'';
	};

}
