pkgs: final: prev:
let
  attr = pkgs.rustPlatform.buildRustPackage {
    inherit (prev) name src;
    cargoHash = "sha256-6Wy202W3jagvymCtuiWnoU4e8QKZV9rPwBxDWZOGdM0=";
  };
in prev.overrideAttrs { inherit (attr) cargoDeps cargoHash; passthru.tests = {};nativeInstallCheckInputs = [];}
