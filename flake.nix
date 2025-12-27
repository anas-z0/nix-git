{
  inputs.nixpkgs.url = "github:nixos/nixpkgs";
  outputs = { nixpkgs, ... }@inputs:
    with builtins;
    with inputs.nixpkgs.lib;
    let
      nodes = (fromJSON (builtins.readFile sources/flake.lock)).nodes;
      sources'' = let a = filterAttrs (n: v: hasAttr "locked" v) nodes;
      in builtins.mapAttrs (n: v: builtins.fetchTree v.locked) a;
      splitLast = str:
        let
          parts = splitString "." str;
          len = length parts;
          prefix = concatStringsSep "." (take (len - 1) parts);
          suffix = last parts;
        in { ${prefix} = { ${suffix} = sources''.${str}; }; };
      recAttrsUpdate = x: builtins.foldl' (a: c: recursiveUpdate a c) { } x;
      sources' = recAttrsUpdate (map splitLast (attrNames sources''));
      sources = mapAttrs (n: v:
        let
          prefix =
            if hasAttr "src" v then { version = v.src.shortRev; } else { };
        in prefix // mapAttrs (n: v: v.outPath) v) sources';
      getPkgs = pkg:
        genAttrs (attrNames inputs.nixpkgs.legacyPackages) (system:
          setAttrByPath (splitString "." pkg) (let
            attr = attrByPath (splitString "." pkg) { }
              inputs.nixpkgs.legacyPackages.${system};
          in attr.overrideAttrs or (x: { }) sources.${pkg}));
      packages' = recAttrsUpdate (map getPkgs (builtins.attrNames sources));

      applyOverlays = start: overlays:
        foldl' (prev: cur:
          recursiveUpdate prev
          (fix (self: cur self (recursiveUpdate start prev)))) { } overlays;
      overlays' = attrNames
        (filterAttrs (n: v: v == "directory") (builtins.readDir ./overlays));
      overlays = map import overlays';
      packages = mapAttrs (system: packages:
        applyOverlays inputs.nixpkgs.legacyPackages.${system}
        ([ (final: prev: packages) ] ++ overlays)) packages';
    in { inherit packages; };
}
