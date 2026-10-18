{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = {self, nixpkgs, flake-utils}:
        flake-utils.lib.eachDefaultSystem (system:
            let
                pkgs = nixpkgs.legacyPackages.${system};
                pkgName = "table-formatter";
                appFiles = pkgs.stdenv.mkDerivation {
                    name = "${pkgName}-files";
                    src = ./.;
                    installPhase = ''
                        mkdir -p $out/share/${pkgName}
                        cp -r ./* $out/share/${pkgName}/
                    '';
                };
                app = pkgs.writeShellApplication {
                    name = pkgName;
                    runtimeInputs = [ pkgs.xdg-utils ];
                    text = ''
                        exec xdg-open "${appFiles}/share/${pkgName}/table_formatter.html"
                    '';
                };
            in
            {
                packages.default = app;
                apps.default = {
                    type = "app";
                    program = "${app}/bin/${pkgName}";
                };
            }
        );
}
