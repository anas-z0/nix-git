pkgs: final: prev:
let
  attr = pkgs.rustPlatform.buildRustPackage {
    inherit (prev) name src;
    cargoHash = "sha256-IVFbIyKfSInS5x6W2x3Xn9BlPpke8QEEhaFBOfBm1O0=";
  };
in prev.overrideAttrs { inherit (attr) cargoDeps cargoHash; passthru.tests = {};nativeInstallCheckInputs = [];}
