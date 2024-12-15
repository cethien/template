{
  outputs = { self, nixpkgs }: 
  let 
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in 
  {
    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = with pkgs; [        
        bun
      ];

      shellHook = ''
        if [ ! -f .envrc ]; then
          echo "use flake" >> .envrc && direnv allow          
        fi

        bun install
      '';
    };
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };
}
