{
    services.nginx = {
        enable = true;

        statusPage = false;
        recommendedTlsSettings = true;
        recommendedOptimisation = true;
        recommendedGzipSettings = true;
    };

    networking.firewall.allowedTCPPorts = [80 443];
}
