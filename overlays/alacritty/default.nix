pkgs: final: prev:
let
  attr = pkgs.rustPlatform.buildRustPackage {
    inherit (prev) name src;
    cargoHash = "sha256-r8u2gzO0vWsPEvnE4dPI3ZfnSWpR2p1b4D8NaZXjFyg=";
  };
in prev.overrideAttrs { inherit (attr) cargoDeps cargoHash; passthru.tests = {};nativeInstallCheckInputs = [];}
