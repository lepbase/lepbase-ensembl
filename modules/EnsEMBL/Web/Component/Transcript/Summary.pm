=head1 LICENSE

Copyright [1999-2016] Wellcome Trust Sanger Institute and the EMBL-European Bioinformatics Institute

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

Copyright [2016] University of Edinburgh

All modifications licensed under the Apache License, Version 2.0, as above.

=cut

package EnsEMBL::Web::Component::Transcript::Summary;

use strict;
use warnings;
use EnsEMBL::Web::Component::Shared;
no warnings 'uninitialized';

use HTML::Entities qw(encode_entities);

use previous qw(
  content
);

sub content {
  my $self = shift;

##################################
### BEGIN LEPBASE MODIFICATIONS...
##################################
  my $html = $self->PREV::content();

  my $hub         = $self->hub;
  my $object      = $self->object;
  my $species     = $hub->species;
  my $table       = $self->new_twocol;
  my $gene        = $object->gene;

  # add blast links
  my $title = $object->stable_id;
  my $slice = $object->slice;
  my $blast_html;
	my $transcripts = $gene->get_all_Transcripts;
	my $index = 0;
  if (@$transcripts > 1){
  	for (my $i = 0; $i < @$transcripts; $i++) {
  		$index = $i;
  		last if $title eq $transcripts->[$i]->stable_id;
  	}
  }
  my $seq = $transcripts->[$index]->seq()->seq();
  $blast_html = EnsEMBL::Web::Component::Shared->sequenceserver_button($title,$seq,'Transcript');
  $seq = undef;
  $seq = $transcripts->[$index]->spliced_seq();
  $blast_html .= EnsEMBL::Web::Component::Shared->sequenceserver_button($title,$seq,'cDNA') if $seq;
  $seq = undef;
  $seq = $transcripts->[$index]->translateable_seq();
  $blast_html .= EnsEMBL::Web::Component::Shared->sequenceserver_button($title,$seq,'CDS') if $seq;
  $seq = undef;
  $seq = $transcripts->[$index]->translate()->seq();
  $blast_html .= EnsEMBL::Web::Component::Shared->sequenceserver_button($transcripts->[$index]->stable_id,$seq,'Protein') if $seq;
  $table->add_row('BLAST',$blast_html);

  $html .= sprintf '<div class="summary_panel">%s</div>', $table->render;
##################################
### ...END LEPBASE MODIFICATIONS
##################################
  return $html;
}

1;
