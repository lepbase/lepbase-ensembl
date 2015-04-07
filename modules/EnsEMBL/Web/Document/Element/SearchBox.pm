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

package EnsEMBL::Web::Document::Element::SearchBox;

### Generates small search box (used in top left corner of pages)

use strict;

sub search_options {
  my $sitename = $_[0]->species_defs->SITE_NAME;

## BEGIN LEPBASE MODIFICATIONS...
 return [
    ($_[0]->hub->species and $_[0]->hub->species !~ /^(common|multi)$/i) ? (
    'ensemblthis'     => { 'label' => 'Search ' . $_[0]->species_defs->SPECIES_COMMON_NAME, 'icon' => 'species/48/' . $_[0]->hub->species . '.png'  }) : (),
    'ensemblunit'     => { 'label' => "Search $sitename",       'icon' => 'e.png'      },
#    'ensembl_genomes' => { 'label' => 'Search Ensembl genomes', 'icon' => 'search/ensembl_genomes.gif'  },
#    'ensembl_all'     => { 'label' => 'Search all species',     'icon' => 'search/ensembl.gif'          },
#    'ebi'             => { 'label' => 'Search EBI',             'icon' => 'search/ebi.gif'              },
  ];
## ...END LEPBASE MODIFICATIONS
}

1;


