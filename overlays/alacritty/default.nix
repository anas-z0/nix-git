pkgs: final: prev:
let
  attr = pkgs.rustPlatform.buildRustPackage {
    inherit (prev) name src;
    cargoHash = "sha256-8SKeOPV0QC6kF9hLqVrbFllkzGa+RabkDhGBT6xcunc=";
  };
in prev.overrideAttrs { inherit (attr) cargoDeps cargoHash; passthru.tests = {};nativeInstallCheckInputs = [];}
