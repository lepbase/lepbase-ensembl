package MyPlugins::SiteDefs;
use strict;


sub update_conf {
    
    $SiteDefs::ENSEMBL_SERVERNAME = 'localhost';
    $SiteDefs::ENSEMBL_PORT = 8080;
    $SiteDefs::ENSEMBL_SERVERNAME     = undef;
#    $SiteDefs::ENSEMBL_PROXY_PORT = 80;

  $SiteDefs::ENSEMBL_MIN_SPARE_SERVERS = 1;
  $SiteDefs::ENSEMBL_MAX_SPARE_SERVERS = 4;
  $SiteDefs::ENSEMBL_BLAST_ENABLED     = 0;
}

1;
