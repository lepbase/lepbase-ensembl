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

package EnsEMBL::Web::Document::Element::Content;

use strict;

use EnsEMBL::Web::Document::Panel;

use base qw(EnsEMBL::Web::Document::Element);


sub content_panel {
  my $self       = shift;
  my $controller = shift;
  my $node       = $controller->node;

  return unless $node;

  my $hub           = $controller->hub;
  my $object        = $controller->object;
  my $configuration = $controller->configuration;

  $self->{'availability'} = $object ? $object->availability : {};

  my %params = (
    object      => $object,
    code        => 'main',
    caption     => $node->data->{'full_caption'} || $node->data->{'concise'} || $node->data->{'caption'},
    omit_header => $controller->page_type eq 'Popup' ? 1 : 0,
    help        => { $hub->species_defs->multiX('ENSEMBL_HELP') }->{join '/', map $hub->$_ || (), qw(type action function)},
  );

  my $panel          = $self->new_panel('Navigation', $controller, %params);
  my @all_components = @{$node->data->{'components'}};
  my @components     = qw(__urgent_messages EnsEMBL::Web::Component::Messages::Urgent);

  for (my $i = 0; $i < $#all_components; $i += 2) {
    push @components, $all_components[$i], $all_components[$i + 1] unless $all_components[$i] eq 'summary';
  }

  push @components, qw(__other_messages EnsEMBL::Web::Component::Messages::Other);

  $panel->add_components(@components);
  $self->add_panel($panel);

###
# BEGIN LEPBASE MODIFICATIONS...
  $hub          = $self->hub;
  my $species      = $hub->species;
  my $species_defs = $hub->species_defs;
  my $img_url      = $self->img_url;
  my $common_name  = $species_defs->SPECIES_COMMON_NAME;
  my $display_name = $species_defs->SPECIES_SCIENTIFIC_NAME.' '.$species_defs->ASSEMBLY_NAME;
  $display_name =~ s/_/ /g;
  my $taxid        = $species_defs->TAXONOMY_ID;
  my $provider_link;

  if ($species_defs->PROVIDER_NAME && ref $species_defs->PROVIDER_NAME eq 'ARRAY') {
    my @providers;
    push @providers, map { $hub->make_link_tag(text => $species_defs->PROVIDER_NAME->[$_], url => $species_defs->PROVIDER_URL->[$_]) } 0 .. scalar @{$species_defs->PROVIDER_NAME} - 1;

    if (@providers) {
      $provider_link = join ', ', @providers;
      $provider_link .= ' | ';
    }
  }
  elsif ($species_defs->PROVIDER_NAME) {
    $provider_link = $hub->make_link_tag(text => $species_defs->PROVIDER_NAME, url => $species_defs->PROVIDER_URL) . " | ";
  }
  if ($species ne 'Multi'){
	my $species_badge = '
    <div class="species-badge" style="padding: 0px 16px 16px 16px">';

  	$species_badge .= qq(<img src="${img_url}species/64/$species.png" alt="" title="" />);

  	if (1){#$common_name =~ /\./) {
   		$species_badge .= qq(<h1>$display_name</h1>);
  	}
  	else {
  	  $species_badge .= qq(<h1>$common_name</h1><p>$display_name</p>);
  	}
  	$species_badge .= '<p class="taxon-id">';
  	$species_badge .= 'Data Source ' . $provider_link if $provider_link;
  	$species_badge .= sprintf q{Taxonomy ID %s}, $hub->get_ExtURL_link("$taxid", 'UNIPROT_TAXONOMY', $taxid) if $taxid;
  	$species_badge .= '</p>';
  	$species_badge .= '</div>'; #species-badge
  	$self->add_panel_first(EnsEMBL::Web::Document::Panel->new(raw => $species_badge));
  }
# ...END LEPBASE MODIFICATIONS
###
}


1;
