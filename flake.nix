{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs: {
    packages = builtins.mapAttrs (system: pkgs: {
      default = pkgs.stdenv.mkDerivation {
        pname = "tree";
        version = "0.0.0";

        src = ./.;

        nativeBuildInputs = [
          pkgs.zig
        ];

        buildPhase = ''
          zig build-exe tree.zig -O ReleaseFast
        '';

        installPhase = ''
          mkdir -p "$out/bin"
          cp tree "$out/bin"
        '';
      };
    }) inputs.nixpkgs.legacyPackages;
  
    devShells = builtins.mapAttrs (system: pkgs: {
      default = pkgs.mkShell {
        packages = [
          pkgs.zig
          pkgs.zls
        ];
      };
    }) inputs.nixpkgs.legacyPackages;
  };
}
