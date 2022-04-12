{ options, config, pkgs, lib, ... }:

with lib;
let cfg = config.plusultra.tools.node;
in {
  options.plusultra.tools.node = with types; {
    enable = mkBoolOpt false "Whether or not to install and configure git";
    pkg = mkOpt package pkgs.nodejs-17_x "The NodeJS package to use";
    prettier = {
      enable = mkBoolOpt true "Whether or not to install Prettier";
      pkg =
        mkOpt package pkgs.nodePackages.prettier "The NodeJS package to use";
    };
    yarn = {
      enable = mkBoolOpt true "Whether or not to install Yarn";
      pkg = mkOpt package pkgs.nodePackages.yarn "The NodeJS package to use";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [ cfg.pkg ] ++ (lib.optional cfg.prettier.enable cfg.prettier.pkg)
      ++ (lib.optional cfg.yarn.enable cfg.yarn.pkg);
  };
}
