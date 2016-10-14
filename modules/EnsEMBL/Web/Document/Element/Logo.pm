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

package EnsEMBL::Web::Document::Element::Logo;

use strict;

sub content {
  my $self   = shift;
  my $url    = $self->href || $self->home_url;
  my $hub    = $self->hub;
  my $type   = $hub->type;
  my $site_name = $self->hub->species_defs->ENSEMBL_SITE_NAME_SHORT;
  my $width = $self->hub->species_defs->MOBILE_LOGO_WIDTH;
  my $height = $self->hub->species_defs->MOBILE_LOGO_HEIGHT;
## BEGIN LEPBASE MODIFICATIONS...
  my $e_logo = '<img src="/i/e.png" alt="'.$site_name.' Home" title="'.$site_name.' Home" class="print_hide" style="width:'.$width.'px;height:'.$height.'px" />';
## ...END LEPBASE MODIFICATIONS

  if ($type eq 'Help') {
## BEGIN LEPBASE MODIFICATIONS...
    return sprintf( '%s%s',
      $self->logo_img, $self->logo_print
## ...END LEPBASE MODIFICATIONS
    );
  }

## BEGIN LEPBASE MODIFICATIONS...
  return sprintf( '<a href="%s">%s</a>%s',
    $url, $self->logo_img, $self->logo_print#, $self->site_menu
## ...END LEPBASE MODIFICATIONS
  );
}


1;
