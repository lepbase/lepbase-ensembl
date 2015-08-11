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

package EnsEMBL::Web::Document::Element::CurrentSpecies;

use strict;

use base qw(EnsEMBL::Web::Document::Element);

sub content {
  my $self         = shift;
  my $hub          = $self->hub;
  my $species      = $hub->species;
  my $species_defs = $hub->species_defs;
  my $img_url      = $self->img_url;
  my $common_name  = $species_defs->SPECIES_COMMON_NAME;
  my $display_name = $species_defs->SPECIES_SCIENTIFIC_NAME;
  
  my $species_badge = '
    <div class="species-badge">';

  $species_badge .= qq(<img src="${img_url}species/64/$species.png" alt="" title="" />);

  if ($common_name =~ /\./) {
    $species_badge .= qq(<h1>$display_name</h1>);
  } else {
    $species_badge .= qq(<h1>$common_name</h1><p>$display_name</p>);
  }

  $species_badge .= '</div>'; #species-badge
  $self->add_panel(EnsEMBL::Web::Document::Panel->new(raw => $species_badge));

  return $content;
}


1;
