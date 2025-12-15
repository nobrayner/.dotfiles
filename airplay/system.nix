{ pkgs, ... }:

{

    services.avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
    };
    
    environment.systemPackages = with pkgs; [
        avahi
        uxplay
    ];

    networking.firewall = {
        enable = true;
        allowedUDPPorts = [ 5353 ];
        allowedTCPPorts = [ 7000 7001 ];
    };

}
