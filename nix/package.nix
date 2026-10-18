{pkgs, ...}:
let
  pkgName = "table-formatter";

  appFiles = pkgs.stdenv.mkDerivation {
    name = "${pkgName}-files";
    src = ../.;
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
    app
