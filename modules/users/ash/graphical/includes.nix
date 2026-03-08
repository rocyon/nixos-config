{__findFile, ...}: {
  den.aspects.ash._.graphical._.includes = {
    includes = [
      <app/ghostty>
      <tools/zoxide>
      (<tools/stylix> {base16Scheme = "catppuccin-mocha";})
    ];

    homeManager = {pkgs, ...}: {
      home.packages = with pkgs; [
        obsidian
      ];

      programs = {
        ghostty.enable = true;
        yazi.enable = true;
        mpv.enable = true;
      };
    };
  };
}
