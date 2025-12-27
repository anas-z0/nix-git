{ packages, pkgs, lib}:
with lib;
with builtins;
let
  cargoPackages = filterAttrs (n: hasAttr "cargoHash") packages.x86_64-linux;
  brokenVendorForHash = mapAttrs (n: v:
    (pkgsCur.rustPlatform.buildRustPackage {
      inherit (v) name src;
      cargoHash = "";
    }).cargoDeps) cargoPackages;
in {
  inherit brokenVendorForHash;
  script = let
    str = (x: ''
      cargoHash=$(nix build '.#hooks.cargo.brokenVendorForHash.${x}' 2>&1 | awk -F 'got: ' '/got: / {print $2}')
      cat << EOF > overlays/${strings.replaceString "." "/" x}/default.nix
      pkgs: final: prev:
      let
        attr = pkgs.rustPlatform.buildRustPackage {
          inherit (prev) name src;
          cargoHash = "$(echo $cargoHash)";
        };
      in prev.overrideAttrs { inherit (attr) cargoDeps cargoHash; passthru.tests = {};nativeInstallCheckInputs = [];}
      EOF
    '');
    list = map str (builtins.attrNames brokenVendorForHash);
  in concatStringsSep "\n" list;
}
