{
  description = "OmniFeed";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };
  outputs = { self, nixpkgs }:
  let
    # Systems supported
    allSystems = [
      "x86_64-linux" # 64-bit Intel/AMD Linux
      "aarch64-linux" # 64-bit ARM Linux
    ];
    # Helper to provide system-specific attributes
    forAllSystems = f: nixpkgs.lib.genAttrs allSystems (system: f {
      pkgs = import nixpkgs { inherit system; };
    });
  in
  {
    devShells = forAllSystems ({ pkgs }: {
      omnifeed = pkgs.mkShell {
        name = "omnifeed";
        packages = with pkgs; [
          figlet
          go # The Go CLI
          gotools # Go tools like goimports, godoc, and others
        ];
        shellHook = ''echo "OmniFeed" | figlet'';
      };
    });
  };
}
