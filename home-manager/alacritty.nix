{
  programs.alacritty = {
    enable = true;

    settings = {
      window.opacity = 0.7;
      font = {
        normal.family = "monospace";
	size = 12.0;
      };
      colors.draw_bold_text_with_bright_colors = true;
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };
}
