=head1 LICENSE

Copyright [1999-2015] Wellcome Trust Sanger Institute and the EMBL-European Bioinformatics Institute

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

package EnsEMBL::Web::Document::Element::FatFooter;

### Optional fat footer - site-specific, so see plugins

use strict;

use base qw(EnsEMBL::Web::Document::Element);

sub content {
  my $html = '<div id="fat-footer">';
  $html .= '<img href="http://ed.ac.uk" title="University of Edinburgh" class="lb-footer-logo" src="img/edinburgh_logo.png">';
  $html .= '<img href="http://cam.ac.uk" title="University of Cambridge" class="lb-footer-logo" src="img/cambridge_logo.jpg">';
  $html .= '<img href="http://york.ac.uk" title="University of York" class="lb-footer-logo" src="img/york_logo.jpg">';
  $html .= '<img href="http://bbsrc.ac.uk" title="bbsrc" class="lb-footer-logo" src="img/bbsrc_logo.jpg">';

  $html .= '</div>';

  return $html;
}

1;
