{
  inputs = {
    "mesa.src" = {
      flake = false;
      url = "gitlab:mesa/mesa?host=gitlab.freedesktop.org";
    };
    "wlroots.src" = {
      flake = false;
      url = "gitlab:wlroots/wlroots?host=gitlab.freedesktop.org";
    };
  };
  outputs = {...}: {};
}
