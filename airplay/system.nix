{ pkgs, ... }:

{

    services.avahi = {
        enable = true;
        nssmdns4 = true;
        # openFirewall = true;
        publish = {
            enable = true;
            userServices = true;
        };
    };
    
    environment.systemPackages = with pkgs; [
        uxplay
    ];

    networking.firewall = {
        enable = true;
        allowedUDPPorts = [ 5353 ];
        allowedTCPPorts = [ 7000 7001 7100 ];
    };

}
