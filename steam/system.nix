{ pkgs, ... }:

{

  # programs.java.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;

    # package = pkgs.steam.override {
    #   withJava = true;
    # };
  };

}
