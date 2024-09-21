{
  services.i2p.enable = true;

  services.i2pd = {
    enable = true;

    ## Options and defaults ##
    # address = null;
    # addressbook.defaulturl = "http://joajgazyztfssty4w2on5oaqksz6tqoxbduy553y34mf4byv6gpq.b32.i2p/export/alive-hosts.txt";
    # addressbook.subscriptions = [
    #   "http://inr.i2p/export/alive-hosts.txt"
    #   "http://i2p-projekt.i2p/hosts.txt"
    #   "http://stats.i2p/cgi-bin/newhosts.txt"
    # ];
    bandwidth = 1024;  # if unset -> default to 32KBps
    # dataDir = null;
    # enableIPv4 = true;
    # enableIPv6 = false;
    # exploratory.inbound.length = 3;
    # exploratory.inbound.quantity = 5;
    # exploratory.outbound.length = 3;
    # exploratory.outbound.quantity = 5;
    # family = null;
    # floodfill = false;
    # ifname = null;
    # ifname4 = null;
    # ifname6 = null;

    # inTunnels = {
    #   "<name>" = {
    #     accessList = [];
    #     address = "127.0.0.1";
    #     crypto.tagsToSend = 40;
    #     destination = "<string>";  # Remote endpoint, I2P hostname or b32.i2p address.
    #     enable = false;
    #     inPort = 0;
    #     inbound.length = 3;
    #     inbound.quantity = 5;
    #     keys = "<name>-keys.dat";
    #     name = "<name>";
    #     outbound.length = 3;
    #     outbound.quantity = 5;
    #     port = 0;  # unsigned int [0 - 65535]
    #   };
    # };
    # outTunnels = { /* same options as inTunnels */ };

    # limits = {
    #   coreSize = 0;
    #   ntcpHard = 0;
    #   ntcpSoft = 0;
    #   ntcpThreads = 1;
    #   openFiles = 0;  # 0 -> use system default
    #   transittunnels = 2500;
    # };

    # logCLFTime = false;
    # logLevel = "error";  # "debug" | "info" | "warn" | "error"
    # nat = true;
    # netid = 2;
    # notransit = false;
    # ntcp = true;
    # ntcp2.enable = true;
    # ntcp2.port = 0;
    # ntcp2.published = false;
    # ntcpProxy = null;
    # package = pkgs.i2pd;
    # port = null;  # if unset -> random between 9111 and 30777
    # precomputation.elgamal = true;

    # proto = {
    #   bob = {
    #     enable = false;
    #     address = "127.0.0.1";
    #     name = "bob";
    #     port = 2827;
    #   };
    #   http = {
    #     enable = false;
    #     address = "127.0.0.1";
    #     auth = false;
    #     hostname = null;
    #     name = "http";
    #     pass = "i2pd";
    #     port = 7070;
    #     strictHeaders = null;  # null | boolean
    #     user = "i2pd";
    #   };
    #   httpProxy = {
    #     address = "127.0.0.1";
    #     enable = false;
    #     inbound.length = 3;
    #     inbound.quantity = 5;
    #     keys = "httpproxy-keys.dat";
    #     latency.max = null;
    #     latency.min = null;
    #     name = "httpproxy";
    #     outbound.length = 3;
    #     outbound.quantity = 5;
    #     outproxy = null;
    #     port = 4444;
    #   };
    #   i2cp = {
    #     enable = false;
    #     address = "127.0.0.1";
    #     name = "i2cp";
    #     port = 7654;
    #   };
    #   i2pControl = {
    #     enable = false;
    #     address = "127.0.0.1";
    #     name = "i2pcontrol";
    #     port = 7650;
    #   };
    #   sam = {
    #     enable = false;
    #     address = "127.0.0.1";
    #     name = "sam";
    #     port = 7656;
    #   };
    #   socksProxy = {
    #     enable = false;
    #     address = "127.0.0.1";
    #     inbound.length = 3;
    #     inbound.quantity = 5;
    #     keys = "socksproxy-keys.dat";
    #     latency.max = null;
    #     latency.min = null;
    #     name = "socksproxy";
    #     outbound.length = 3;
    #     outbound.quantity = 5;
    #     outproxy = "127.0.0.1";
    #     outproxyEnable = false;
    #     outproxyPort = 4444;
    #     port = 4447;
    #   };
    # };

    # reseed = {
    #   file = null;
    #   floodfill = null;
    #   proxy = null;
    #   urls = [];
    #   verify = false;
    #   zipfile = null;
    # };

    # share = 100;  # limit of transit traffic bandwidth in percent
    # ssu = true;

    # trust = {
    #   enable = false;
    #   family = null;
    #   hidden = false;
    #   routers = [];
    # };

    # upnp.enable = false;
    # upnp.name = "I2Pd";

    # websocket = {
    #   enable = false;
    #   address = "127.0.0.1";
    #   name = "websockets";
    #   port = 7666;
    # };

    # yggdrasil.enable = false;
    # yggdrasil.address = null;
  };
}
