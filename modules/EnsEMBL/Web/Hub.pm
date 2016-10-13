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

package EnsEMBL::Web::Hub;

### NAME: EnsEMBL::Web::Hub
### A centralised object giving access to data connections and the web environment

### DESCRIPTION:
### Hub uses the Flyweight design pattern to create a single object that is
### passed around between all other objects that require data connectivity.
### The Hub stores information about the current web page and its environment,
### including cgi parameters, settings parsed from the URL, browser session,
### database connections, and so on.

use strict;

use Carp;
use CGI;
use URI::Escape qw(uri_escape uri_unescape);

use EnsEMBL::Web::SpeciesDefs;

use base qw(EnsEMBL::Web::Root);

## BEGIN LEPBASE MODIFICATIONS...

sub get_species_info {
  ## Gets info about all valid species or an individual species if url name provided
  ## @param URL name for a species (String) (optional)
  ## @return Hashref with keys: key, name, common, scientific and group for single species, OR hashref of hashrefs for { species url name => { species info } .. }
  my ($self, $species) = @_;

  unless ($self->{'_species_info_loaded'} || $species && $self->{'_species_info'}{$species}) {

    my $species_defs      = $self->species_defs;
    my @required_species  = $species_defs->valid_species;
       @required_species  = grep {$species eq $_} @required_species if $species;

    for (@required_species) {
      $self->{'_species_info'}{$_} = {
        'key'         => $_,
        'url'         => '/'.$species_defs->get_config($_, 'SPECIES_URL'),
        'name'        => $species_defs->get_config($_, 'SPECIES_BIO_NAME'),
        'common'      => $species_defs->get_config($_, 'SPECIES_COMMON_NAME'),
        'scientific'  => $species_defs->get_config($_, 'SPECIES_SCIENTIFIC_NAME'),
        'assembly'    => $species_defs->get_config($_, 'ASSEMBLY_NAME'),
        'group'       => $species_defs->get_config($_, 'SPECIES_GROUP')
      } unless exists $self->{'_species_info'}{$_};
    }

    $self->{'_species_info_loaded'} = !$species;
  }

  return $species ? $self->{'_species_info'}{$species} : $self->{'_species_info'};
}



sub get_species_set {
  my $self         = shift;
  my $set          = shift;
  my $species_defs = $self->species_defs;
  my @species   = @{$species_defs->$set || []};
  return \@species;
}

sub get_favourite_species {
  my $self         = shift;
  my $species_defs = $self->species_defs;
  my @fav          = @{$species_defs->DEFAULT_FAVOURITES || []};
     @fav          = ($species_defs->ENSEMBL_PRIMARY_SPECIES, $species_defs->ENSEMBL_SECONDARY_SPECIES) unless scalar @favourites;
  my %remove       = map { $_ => 1 } @{$species_defs->ASSEMBLY_ONLY || []};
  my %fav          = map { $_ => 1 } @fav;
  foreach my $key (keys %remove){
    $fav{$key} = 0;
  }
  my @favourites;
  while (my $sp = shift @fav){
    push @favourites, $sp if $fax{$sp};
  }
  return \@favourites;
}

## ...END LEPBASE MODIFICATIONS

1;
