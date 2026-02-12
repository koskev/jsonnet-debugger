{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    {
      self,
      flake-utils,
      nixpkgs,

    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = (import nixpkgs) {
          inherit system;
        };

      in
      {
        defaultPackage = pkgs.buildGoModule {
          pname = "jsonnet-debugger";
          version = "0.0.1";

          src = ./.;
          vendorHash = "sha256-e4Bw8fP7gKnOvdPttlTkKIFy5kzPpHETqfIiJwIUMws=";

        };
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            go
            gopls

            go-jsonnet
          ];
        };
      }

    );
}
