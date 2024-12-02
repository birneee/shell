{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let 
          pkgs = import nixpkgs {
            inherit system;
          };
        in 
        {
          packages.default = pkgs.stdenv.mkDerivation {
            name = "pop-shell";
            src = self;
            makeFlags = [
              "XDG_DATA_HOME=$(out)/share"
            ];
            nativeBuildInputs = with pkgs; [
              typescript
            ];
          };
          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              typescript
              glib
            ];
          };
        }
      );
}
