{
  den,
  inputs,
  ...
}: {
  flake-file.inputs = {
    nvf.url = "github:notashelf/nvf";
  };

  den.aspects.ash._.nvf = {
    homeManager = {
      lib,
      pkgs,
      ...
    }: {
      # imports = [inputs.nvf.homeManagerModules.nvf];
      #
      # stylix.targets.nvf.enable = true;
      #
      # programs.nvf = {
      #   enable = true;
      #   enableManpages = true;
      #
      #   settings2 = import ./_nvf/config.nix {inherit lib pkgs;};
      #   settings = {
      #     vi.viAlias = false;
      #     vim.viAlias = true;
      #     vim.lsp = {
      #       enable = true;
      #     };
      #   };
      # };
    };
  };
}
