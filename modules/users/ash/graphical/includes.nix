{__findFile,...}: {
  den.aspects.ash._.graphical._.includes = {
    includes = [
      <app/ghostty>
      <tools/zoxide>
    ];

    homeManager.programs = {
      ghostty.enable = true;
      yazi.enable = true;
      mpv.enable = true;
    };
  };
}
