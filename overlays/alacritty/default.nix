pkgs: final: prev:
let
  attr = pkgs.rustPlatform.buildRustPackage {
    inherit (prev) name src;
    cargoHash = "";
  };
in prev.overrideAttrs { inherit (attr) cargoDeps cargoHash; passthru.tests = {};nativeInstallCheckInputs = [];}
