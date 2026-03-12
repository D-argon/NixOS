{
  programs.nixvim = {
    enable = true;

    opts = {
      number = true;
      relativenumber = true;

      # Signs
      signcolumn = "yes";

      # Tabs
      shiftwidth = 2;
      smartindent = true;

      # Wrap
      wrap = true;
    };

    colorschemes.rose-pine.enable = true;
    plugins = {
      lualine.enable = true;
      lsp = {
        enable = true;

        servers = {
          nixd.enable = true;
          pyright.enable = true;
        };
      };
    };

    lsp.inlayHints.enable = true;

    clipboard.providers.xclip.enable = true;
  };
}
