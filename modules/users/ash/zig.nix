{inputs, ...}: {
  flake-file.inputs = {
    zig.url = "github:mitchellh/zig-overlay";
  };

  den.aspects.ash._.zig.imports = [
    ({host,...}: {
      homeManager.home.packages = [inputs.zig.packages.${host.system}.master];
    })
  ];
}
