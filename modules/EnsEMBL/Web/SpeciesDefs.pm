=head1 LICENSE

Copyright [1999-2014] Wellcome Trust Sanger Institute and the EMBL-European Bioinformatics Institute

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

package EnsEMBL::Web::SpeciesDefs;

### SpeciesDefs - Ensembl web configuration accessor

### This module provides programatic access to the web site configuration
### data stored in the $ENSEMBL_WEBROOT/conf/*.ini (INI) files. See
### $ENSEMBL_WEBROOT/conf/ini.README for details.

### Owing to the overhead implicit in parsing the INI files, two levels of
### caching (memory, filesystem) have been implemented. To update changes
### made to an INI file, the running process (e.g. httpd) must be halted,
### and the $ENSEMBL_WEBROOT/conf/config.packed file removed. In the
### absence of a cache, the INI files are automatically parsed parsed at
### object instantiation. In the case of the Ensembl web site, this occurs
### at server startup via the $ENSEMBL_WEBROOT/conf/perl.startup
### script. The filesystem cache is not enabled by default; the
### SpeciesDefs::store method is used to do this explicitly.

### Example usage:

###  use SpeciesDefs;
###  my $speciesdefs  = SpeciesDefs->new;

###  # List all configured species
###  my @species = $speciesdefs->valid_species();

###  # Test to see whether a species is configured
###  if( scalar( $species_defs->valid_species('Homo_sapiens') ){ }

###  # Getting a setting (parameter value/section data) from the config
###  my $sp_name = $speciesdefs->get_config('Homo_sapiens','SPECIES_COMMON_NAME');

###  # Alternative setting getter - uses autoloader
###  my $sp_bio_name = $speciesdefs->SPECIE_%S_COMMON_NAME('Homo_sapiens');

###  # Can also use the ENSEMBL_SPECIES environment variable
###  ENV{'ENSEMBL_SPECIES'} = 'Homo_sapiens';
###  my $sp_bio_name = $speciesdefs->SPECIES_COMMON_NAME;

###  # Getting a parameter with multiple values
###  my( @chromosomes ) = @{$speciesdefs->ENSEMBL_CHROMOSOMES};

use strict;
use warnings;
no warnings "uninitialized";

use Carp qw(cluck);
use Data::Dumper;
use DBI;
use File::Spec;
use Hash::Merge qw(merge);
use Storable qw(lock_nstore lock_retrieve thaw);
use Time::HiRes qw(time);
use Fcntl qw(O_WRONLY O_CREAT);

use SiteDefs;# qw(:ALL);

use Bio::EnsEMBL::Registry;
use Bio::EnsEMBL::Utils::ConfigRegistry;
use Bio::EnsEMBL::Utils::Eprof qw(eprof_start eprof_end eprof_dump);
use Bio::EnsEMBL::Utils::Exception qw(verbose);
use Bio::EnsEMBL::DBSQL::DataFileAdaptor;

use EnsEMBL::Web::ConfigPacker;
use EnsEMBL::Web::DASConfig;
use EnsEMBL::Web::Tools::WebTree;
use EnsEMBL::Web::Tools::RobotsTxt;
use EnsEMBL::Web::Tools::OpenSearchDescription;
use EnsEMBL::Web::Tools::Registry;
use EnsEMBL::Web::Tools::MartRegistry;

use base qw(EnsEMBL::Web::Root);

our $AUTOLOAD;
our $CONF;

sub new {
  ### c
  my $class = shift;

  verbose($SiteDefs::ENSEMBL_API_VERBOSITY);

  my $self = bless({
    _start_time => undef,
    _last_time  => undef,
    timer       => undef
  }, $class);

  my $conffile = "$SiteDefs::ENSEMBL_CONF_DIRS[0]/$SiteDefs::ENSEMBL_CONFIG_FILENAME";
  
  $self->{'_filename'} = $conffile;

  # TODO - these need to be pulled in dynamically from appropriate modules
  my @params = qw/ph g h r t v sv m db pt rf ex vf svf fdb lrg vdb gt/;
  $self->{'_core_params'} = \@params;
  
  $self->parse unless $CONF;

  ## Diagnostic - sets up back trace of point at which new was
  ## called - useful for trying to track down where the cacheing
  ## is taking place
  $self->{'_new_caller_array'} = [];

  if (1) {
    my $C = 0;

#    while (my @T = caller($C)) {
#      $self->{'_new_caller_array'}[$C] = \@T;
#      $C++;
#    }
  }

  $self->{'_storage'} = $CONF->{'_storage'};

  return $self;
}




sub parse {
  ### Retrieves a stored configuration or creates a new one
  ### Returns: boolean
  ### Caller: $self->new when filesystem and memory caches are empty
  
  my $self = shift;
  
  $CONF = {};
  
  my $reg_conf = EnsEMBL::Web::Tools::Registry->new($CONF);

  $self->{'_start_time'} = time;
  $self->{'_last_time'}  = $self->{'_start_time'};
  
  if (!$SiteDefs::ENSEMBL_CONFIG_BUILD && -e $self->{'_filename'}) {
    warn " Retrieving conf from $self->{'_filename'}\n";
    $self->retrieve;
    $reg_conf->configure;
    return 1;
  }
  
#  $self->_get_valid_urls; # under development
  $self->_parse;
  $self->store;
  $reg_conf->configure;
  
  EnsEMBL::Web::Tools::RobotsTxt::create($self->ENSEMBL_DATASETS, $self);
  EnsEMBL::Web::Tools::OpenSearchDescription::create($self);
  
  ## Set location for file-based data
  Bio::EnsEMBL::DBSQL::DataFileAdaptor->global_base_path($self->DATAFILE_BASE_PATH);
  
  $self->{'_parse_caller_array'} = [];
  
  my $C = 0;
  
#  while (my @T = caller($C)) {
#    $self->{'_parse_caller_array'}[$C] = \@T;
#    $C++;
#  }
}


1;
