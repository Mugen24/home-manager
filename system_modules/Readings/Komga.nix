{ username, pkgs }: 
{
    services.komga = {
        enable = true;
        user = username;
        group = "manga";
        stateDir = "/var/lib/komga";
        port = 9111;
    };
}
