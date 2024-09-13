{
  description = "A systems language designed for OOP & embedded use";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    systems.url = "github:nix-systems/default-linux";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      systems,
      ...
    }@inputs:
    let
      inherit (nixpkgs) lib;
    in
    flake-utils.lib.eachSystem (import systems) (
      system:
      let
        pkgs = nixpkgs.legacyPackages."${system}";
        llvmPackages = pkgs.llvmPackages_19;

        self = {
          packages.default = pkgs.buildDartApplication {
            pname = "mirai";
            version = "0.1.0${lib.optionalString (self ? shortRev) "-git+${self.shortRev}"}";

            src = lib.cleanSource inputs.self;

            pubspecLock = lib.importJSON ./pubspec.lock.json;

            sdkSourceBuilders = {
              # https://github.com/dart-lang/pub/blob/e1fbda73d1ac597474b82882ee0bf6ecea5df108/lib/src/sdk/dart.dart#L80
              "dart" =
                name:
                pkgs.runCommand "dart-sdk-${name}" { passthru.packageRoot = "."; } ''
                  for path in '${pkgs.dart}/pkg/${name}'; do
                    if [ -d "$path" ]; then
                      ln -s "$path" "$out"
                      break
                    fi
                  done

                  if [ ! -e "$out" ]; then
                    echo 1>&2 'The Dart SDK does not contain the requested package: ${name}!'
                    exit 1
                  fi
                '';
            };

            meta.mainProgram = "mirai";
          };

          legacyPackages = pkgs;

          devShells.default = self.packages.default.overrideAttrs (
            f: p: { nativeBuildInputs = p.nativeBuildInputs ++ [ pkgs.yq ]; }
          );
        };
      in
      self
    );
}
