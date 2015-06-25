=head1 LICENSE

Copyright [2009-2014] EMBL-European Bioinformatics Institute

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

=cut

=head1 MODIFICATIONS

Copyright [2014-2015] University of Edinburgh

All modifications licensed under the Apache License, Version 2.0, as above.

=cut

package EG::Common::SiteDefs;
use strict;

use LepBase::Access;
use Data::Dumper;

sub update_conf {
  map {delete($SiteDefs::__species_aliases{$_}) } keys %SiteDefs::__species_aliases;
  
## BEGIN LEPBASE MODIFICATIONS...
  $SiteDefs::SITE_RELEASE_VERSION = $Access::SITE_RELEASE_VERSION;;
  $SiteDefs::SITE_RELEASE_DATE = $Access::SITE_RELEASE_DATE;
## ...END LEPBASE MODIFICATIONS
  
## BEGIN LEPBASE MODIFICATIONS...
  $SiteDefs::SITE_MISSION = 'LepBase provides a multi-genome browser for the Lepidoptera research community.';
## ...END LEPBASE MODIFICATIONS
  
  $SiteDefs::ENSEMBL_LONGPROCESS_MINTIME    = 10;
  
  @SiteDefs::ENSEMBL_PERL_DIRS    = (
    $SiteDefs::ENSEMBL_WEBROOT.'/perl',
    $SiteDefs::ENSEMBL_SERVERROOT.'/eg-web-common/perl',
  );

  push (@SiteDefs::ENSEMBL_LIB_DIRS, 
    $SiteDefs::ENSEMBL_SERVERROOT . '/ensemblgenomes-api/modules'
    $SiteDefs::ENSEMBL_SERVERROOT . '/ensembl-io/modules',
  );
  
  $SiteDefs::TEMPLATE_ROOT = $SiteDefs::ENSEMBL_SERVERROOT.'/eg-web-common/templates';
      
  $SiteDefs::DOCSEARCH_INDEX_DIR = $SiteDefs::ENSEMBL_TMP_DIR . '/docsearch_index';
  
  $SiteDefs::OBJECT_TO_SCRIPT->{'Info'} = 'AltPage';
  
  $SiteDefs::ENSEMBL_BLASTSCRIPT       = $SiteDefs::ENSEMBL_SERVERROOT."/utils/parse_blast.pl";
## BEGIN LEPBASE MODIFICATIONS...
  $SiteDefs::ENSEMBL_BLAST_ENABLED     = 0;   
  $SiteDefs::ENSEMBL_ENASEARCH_ENABLED = 0;
  $SiteDefs::ENSEMBL_LOGINS            = 0;
## ...END LEPBASE MODIFICATIONS
  
## BEGIN LEPBASE MODIFICATIONS...
  $SiteDefs::APACHE_BIN   = '/usr/local/apache2/bin/httpd';
  $SiteDefs::APACHE_DIR   = '/usr/local/apache2';
## ...END LEPBASE MODIFICATIONS
  $SiteDefs::SAMTOOLS_DIR = '/nfs/public/rw/ensembl/samtools';
  
## BEGIN LEPBASE MODIFICATIONS...
  $SiteDefs::ENSEMBL_USERDB_HOST = $Access::LEPBASE_USERDB_HOST;
  $SiteDefs::ENSEMBL_USERDB_PORT = $Access::LEPBASE_USERDB_PORT;
  $SiteDefs::ENSEMBL_USERDB_USER = $Access::LEPBASE_USERDB_USER;
  $SiteDefs::ENSEMBL_USERDB_PASS = $Access::LEPBASE_USERDB_PASS;
  $SiteDefs::ENSEMBL_USERDB_NAME = $Access::LEPBASE_USERDB_NAME;
## ...END LEPBASE MODIFICATIONS

  $SiteDefs::ROSE_DB_DATABASES->{'user'}   = {
    database  => $SiteDefs::ENSEMBL_USERDB_NAME,
    host      => $SiteDefs::ENSEMBL_USERDB_HOST,
    port      => $SiteDefs::ENSEMBL_USERDB_PORT,
## BEGIN LEPBASE MODIFICATIONS...
    username  => $SiteDefs::ENSEMBL_USERDB_USER,
    password  => $SiteDefs::ENSEMBL_USERDB_PASS,
## ...END LEPBASE MODIFICATIONS
  };
    # Flag to enable/disable BLAST, VEP, Assembly Converter
  $SiteDefs::ENSEMBL_BLAST_ENABLED  = 0;
  $SiteDefs::ENSEMBL_VEP_ENABLED    = 0;
  $SiteDefs::ENSEMBL_MART_ENABLED   = 0;
  $SiteDefs::ENSEMBL_AC_ENABLED     = 0;

  $SiteDefs::WUBLAST_REST_ENDPOINT  = 'http://www.ebi.ac.uk/Tools/services/rest/wublast';

  $SiteDefs::ENSEMBL_REST_URL     = 'http://rest.ensemblgenomes.org';
  $SiteDefs::ENSEMBL_REST_DOC_URL = 'http://ensemblgenomes.org/info/access/rest';

}

1;

