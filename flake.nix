{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {self, nixpkgs, flake-utils}:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = {
          table-formatter = pkgs.callPackage ./nix/package.nix {};
          default = self.packages.${system}.table-formatter;
        };
      }
    ) // {
      homeManagerModules.table-formatter = import ./nix/hm-module.nix;
      homeManagerModules.default = self.homeManagerModules.table-formatter;

    };
}
