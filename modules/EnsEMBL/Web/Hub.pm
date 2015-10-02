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

sub get_species_set {
  my $self         = shift;
  my $set          = shift;
  my $species_defs = $self->species_defs;
  my @species   = @{$species_defs->$set || []};
  return \@species;
}

## ...END LEPBASE MODIFICATIONS

1;