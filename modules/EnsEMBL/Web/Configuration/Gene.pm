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

Copyright [2014-2016] University of Edinburgh

All modifications licensed under the Apache License, Version 2.0, as above.

=cut

package EnsEMBL::Web::Configuration::Gene;


use previous qw(modify_tree);

sub modify_tree {
  my $self = shift;

  $self->PREV::modify_tree(@_);

  #my $compara_menu = $self->get_node('PanCompara');
  #my $pcdb_name = $self->hub->species_defs->PAN_COMPARA_DB_NAME;
  #$compara_menu->set('caption', $pcdb_name) if $compara_menu && $pcdb_name;
  $self->delete_node('PanCompara');
  $self->delete_node('Family');
  $self->delete_node('Gene_families');
  $self->delete_node('Alleles');
  $self->delete_node('TranscriptComparison');
  $self->delete_node('Evidence');
  $self->delete_node('SecondaryStructure');
  $self->delete_node('Regulation');
  $self->delete_node('Expression');
  $self->delete_node('Compara_Alignments');
  $self->delete_node('SpeciesTree');
  $self->delete_node('Variation');
  $self->delete_node('StructuralVariation_Gene');
  $self->delete_node('ExternalData');
  $self->delete_node('UserAnnotation');
  $self->delete_node('History');
  $self->delete_node('Idhistory');
  $self->delete_node('Phenotype');
}

1;
