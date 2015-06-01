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

=head1 MODIFICATIONS

Copyright [2014-2015] University of Edinburgh

All modifications licensed under the Apache License, Version 2.0, as above.

=cut

package EnsEMBL::Web::CDBI;

### NAME: EnsEMBL::Web::CDBI
### Base class for ORM objects based on Class::DBI::Sweet  

### STATUS: At Risk
### We are in the process of replacing Class::DBI-based domain objects
### with Rose::DB objects - once all such objects have been migrated, 
### this module will be removed.

use strict;
use warnings;
no warnings 'uninitialized';



sub propagate_cache_tags {
  my $self  = shift;
## BEGIN LEPBASE MODIFICATIONS...
  # comment out for debugging
  #$ENV{'CACHE_TAGS'}{$_} = $_ for @_, $self->table;
## ...END LEPBASE MODIFICATIONS
}


1;
