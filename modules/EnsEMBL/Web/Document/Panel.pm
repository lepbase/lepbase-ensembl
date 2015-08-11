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

package EnsEMBL::Web::Document::Panel;

use strict;

use HTML::Entities qw(encode_entities);

use EnsEMBL::Web::Document::Renderer::String;

use base qw(EnsEMBL::Web::Root);

sub new {
  my $class = shift;
  
  my $self = {
    _renderer       => undef,
    components      => {},
    component_order => [],
    @_
  };
  
  bless $self, $class;
  return $self;
}




sub content {
  my $self = shift;
  my $hub          = $self->hub;
  my $species_defs = $hub->species_defs;
  my $display_name = $species_defs->SPECIES_SCIENTIFIC_NAME;
  
  return $self->{'raw'} if exists $self->{'raw'};
  
  my $hub        = $self->hub;
  my $status     = $hub ? $hub->param($self->{'status'}) : undef;
  my $content    = sprintf '%s<p class="invisible">.</p>', $status ne 'off' ? sprintf('<div class="content">%s</div>', $self->component_content) : '';
  my $panel_type = $self->renderer->{'_modal_dialog_'} ? 'ModalContent' : 'Content';
  
  if (!$self->{'omit_header'}) {

    my $caption = '';
    if ($self->{'caption'}) {
      my $summary = $self->{'code'} eq 'summary_panel' ? 1 : 0;
      if ($summary) {
        $caption = $self->_caption_h1;
      }
      else {
        $caption = $self->_caption_h2_with_helplink;
      }

      $content = qq{
        <div class="nav-heading">
          $caption
          $display_name
          <p class="invisible">.</p>
        </div>
        $content
      };
    }
  }
  
  return qq{
    <div class="panel js_panel">
      <input type="hidden" class="panel_type" value="$panel_type" />
      $content
    </div>
  };
}



1;
