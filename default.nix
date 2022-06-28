{ pkgs ? (import <nixpkgs> {}).pkgsCross.mingwW64 }:

pkgs.stdenv.mkDerivation {
  name = "eldenring-parameter-randomizer";
  src = ./.;
  nativeBuildInputs = with pkgs.buildPackages; [
    gnumake
  ];
  installPhase = ''
    make install DESTDIR=$out
    cp "${pkgs.windows.mcfgthreads}/bin/"*.dll $out/
    chmod 644 $out/*.dll
  '';
}
