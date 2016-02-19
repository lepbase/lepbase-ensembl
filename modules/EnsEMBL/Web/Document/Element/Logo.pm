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
## BEGIN LEPBASE MODIFICATIONS...
  my $e_logo = '<img src="/i/e.png" alt="LepBase Home" title="LepBase Home" class="print_hide" style="width:43px;height:40px" />'; 
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

sub logo_img {
### a
  my $self = shift;
  return sprintf(
    '<img src="%s%s?v=2" alt="%s" title="%s" class="print_hide" style="width:%spx;height:%spx" />',
    $self->img_url, $self->image, $self->alt, $self->alt, $self->width, $self->height
  );
}

sub e_logo {
### a
  my $self = shift;
## BEGIN LEPBASE MODIFICATIONS...
  my $alt = 'LepBase Home';
## ...END LEPBASE MODIFICATIONS
  return sprintf(
    '<a href="%s"><img src="%s%s" alt="%s" title="%s" class="print_hide" style="width:%spx;height:%spx" /></a>',
## BEGIN LEPBASE MODIFICATIONS...
    'http://www.lepbase.org/', $self->img_url, 'e.png', $alt, $alt, 43, 40
## ...END LEPBASE MODIFICATIONS
  );
}

sub site_menu {
  return q{
    <span class="print_hide">
      <span id="site_menu_button">&#9660;</span>
      <ul id="site_menu" style="display:none">
        <li><a href="http://www.ensemblgenomes.org">Ensembl Genomes</a></li>
        <li><a href="http://bacteria.ensembl.org">Ensembl Bacteria</a></li>
        <li><a href="http://protists.ensembl.org">Ensembl Protists</a></li>
        <li><a href="http://fungi.ensembl.org">Ensembl Fungi</a></li>
        <li><a href="http://plants.ensembl.org">Ensembl Plants</a></li>
        <li><a href="http://metazoa.ensembl.org">Ensembl Metazoa</a></li>
        <li><a href="http://www.ensembl.org">Ensembl (vertebrates)</a></li>
      </ul>
    </span>
  };
}

1;
