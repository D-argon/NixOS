{
  programs.alacritty = {
    enable = true;

    settings = {
        keyboard.bindings = [
          { key = "Return"; mods = "Alt|Shift"; action = "SpawnNewInstance";}
        ];
      window.opacity = 0.7;
      font = {
        normal.family = "monospace";
	size = 12.0;
      };
      colors = {
        draw_bold_text_with_bright_colors = true;
	primary = {
		foreground = "#E2A6C9";
		background = "#1E1B22";
	};
      };

      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };
}
