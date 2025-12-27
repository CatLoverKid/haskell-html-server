{
  description = "Web Server API";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      
      haskellPackages = pkgs.haskellPackages;
      
      haskell-html-server = haskellPackages.callCabal2nix "haskell-html-server"./. {};
    in
    {
      packages.${system}.default = haskell-html-server;
      
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with haskellPackages; [
          ghc
          cabal-install
          haskell-language-server
          servant
          servant-server
          servant-blaze
          warp
          blaze-html
        ];
        
        nativeBuildInputs = with pkgs; [
          zlib
          pkg-config
        ];
      };
    };
}
