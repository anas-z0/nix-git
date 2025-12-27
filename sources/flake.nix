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
    "bees.src" = {
      flake = false;
      url = "github:Zygo/bees";
    };
    "alacritty.src" = {
      flake = false;
      url = "github:alacritty/alacritty";
    };
    "alacritty-graphic.src" = {
      flake = false;
      url = "github:ayosec/alacritty";
    };
    "ananicy-rules-cachyos.src" = {
      flake = false;
      url = "github:CachyOS/ananicy-rules";
    };
    "ananicy-cpp.src" = {
      flake = false;
      url = "github:ananicy-cpp/ananicy-cpp";
    };
    "appmenu-glib-translator.src" = {
      flake = false;
      url = "github:vala-panel-project/vala-panel-appmenu";
    };

  };
  outputs = {...}: {};
}
