{
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/top-level/haskell-packages.nix
  pkgs ? import ./nix/pkgs.nix
}:
let

    wrappedScript = name: script: deps: envArgs: pkgs.runCommandLocal name
      {
        inherit script;
        buildInputs = [ pkgs.makeWrapper ];
      } ''
      makeWrapper $script $out/bin/${name} \
        --prefix PATH : ${pkgs.lib.makeBinPath deps} \
        ${pkgs.lib.strings.concatStringsSep " "
          (pkgs.lib.attrsets.mapAttrsToList
            (n: v: ''--set-default "${n}" "${v}"'') envArgs)}
    '';
    myphp = wrappedScript "php" ./run-php.sh [pkgs.php] {};
in
#  https://input-output-hk.github.io/haskell.nix/tutorials/development/
pkgs.haskellPackages.shellFor {
  packages = ps : [ ps.phphaskell ];
  buildInputs = [
        pkgs.ghcid
        pkgs.cabal-install
        myphp
        ];
  exactDeps = true;
  NIX_PATH="nixpkgs=${pkgs.path}:.";
}
