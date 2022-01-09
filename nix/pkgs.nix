import ./pin.nix {
  config = {

    packageOverrides = pkgs: {
        haskell = pkgs.lib.recursiveUpdate pkgs.haskell {
        packageOverrides = hpNew: hpOld: {
            phphaskell = hpNew.callPackage ../default.nix {};
            };
        };
    };
  };
}
