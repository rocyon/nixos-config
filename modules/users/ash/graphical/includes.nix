{__findFile, ...}: {
  den.aspects.ash._.graphical._.includes = {
    includes = [
      <app/ghostty>
      <app/helium>
      <app/zen>
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
