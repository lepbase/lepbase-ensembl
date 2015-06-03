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

package EnsEMBL::Web::DBSQL::ConfigAdaptor;

use strict;

use Data::Dumper;
use DBI;
use Digest::MD5 qw(md5_hex);
use HTML::Entities qw(encode_entities decode_entities);

use EnsEMBL::Web::Controller;



sub set_cache_tags {
  my ($self, $config) = @_;
## BEGIN LEPBASE MODIFICATIONS...
 # $ENV{'CACHE_TAGS'}{$config->{'type'}} = sprintf '%s[%s]', uc($config->{'type'}), md5_hex(join '::', $config->{'code'}, $self->serialize_data($config->{'data'})) if $config;
## ...END LEPBASE MODIFICATIONS
}

# not currently used, but written in case we need it in future
sub disconnect {
  return unless $DBH;
  $DBH->disconnect;
  undef $DBH;
}

1;
