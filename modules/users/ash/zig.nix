{inputs, ...}: {
  flake-file.inputs = {
    zig.url = "github:mitchellh/zig-overlay";
  };

  den.aspects.ash._.zig = {
    homeManager = {inputs',...}: {
      home.packages = [inputs'.zig.packages.master];
    };
  };
}
