{
  description = "OmniFeed";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
  };
  outputs = { self, nixpkgs, pre-commit-hooks }:
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
    # TODO Work in Progress
    packages = forAllSystems ({ pkgs }: {
      default = pkgs.buildGoModule {
        pname = "omnifeed";
        version = "unversioned";
        src = ./.;
        ldflags = [ "-s" "-w" "-X main.version=dev" "-X main.builtBy=flake" ];
        CGO_ENABLED = 0;
        doCheck = false;
        vendorHash = "";
      };
    });

    devShells = forAllSystems ({ pkgs }: {
      default = pkgs.mkShell {
        name = "omnifeed";
        inherit pre-commit-hooks;
        packages = with pkgs; [
          figlet
          go            # The Go CLI
          gotools       # Go tools like goimports, godoc, and others
          goreleaser    # Goreleaser for the process of releasing the project
          golangci-lint # Go linters tool
        ];
        shellHook = ''echo "OmniFeed" | figlet'';
      };
      pair = pkgs.mkShell {
        name = "omnifeed";
        inherit pre-commit-hooks;
        packages = with pkgs; [
          figlet
          mob
          go            # The Go CLI
          gotools       # Go tools like goimports, godoc, and others
          goreleaser    # Goreleaser for the process of releasing the project
          golangci-lint # Go linters tool
        ];
        shellHook = ''echo "OmniFeed with Mob" | figlet'';
      };
    });
  };
}
