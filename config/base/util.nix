lib:
let
  recursiveIterateRecreate = set: iter:
    builtins.listToAttrs(
      builtins.concatMap iter (builtins.attrNames set)
    );
  def = lib.mkOverride 250;
  makeDefault = attrs:
    recursiveIterateRecreate attrs (key:
      let
        value = attrs.${key};
        r = v: [(lib.nameValuePair key v)];
      in
        if builtins.isAttrs value then
          r (makeDefault value)
        else if builtins.isBool value then
          r (def value)
        else r value);
in
  {
    inherit makeDefault;
  }
