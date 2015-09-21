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

package EnsEMBL::Web::Document::Element::ToolLinks;

### Generates links to site tools - BLAST, help, login, etc (currently in masthead)

use strict;

sub content {
  my $self    = shift;
  my $hub     = $self->hub;
  my $species = $hub->species;
     $species = !$species || $species eq 'Multi' || $species eq 'common' ? 'Multi' : $species;
  my @links; # = sprintf '<a class="constant" href="%s">Home</a>', $self->home;
#  push @links, qq{<a class="constant" href="/$species/blastview">BLAST</a>} if $self->blast;
###EG  
  if ($self->hub->species_defs->ENSEMBL_ENASEARCH_ENABLED) {
      push @links,   '<a class="constant" href="/Multi/enasearch">Sequence Search</a>';
  }

## BEGIN LEPBASE MODIFICATIONS...
  my $sd    = $self->species_defs;
  my $blog  = $sd->ENSEMBL_BLOG_URL;
  push @links,   '<a class="constant" href="http://blast.lepbase.org" title="BLAST">BLAST</a>';
  push @links,   '<a class="constant" href="/downloads.html" title="downloads.html">Downloads</a>';
  push @links,   '<a class="constant" href="http://webapollo.lepbase.org" title="Web Apollo">Web Apollo</a>';
  push @links,   '<a class="constant" href="'.$blog.'" title="lepbase.org">Blog</a>'                  if $blog;
## ...END LEPBASE MODIFICATIONS
  my $last  = pop @links;
  my $tools = join '', map "<li>$_</li>", @links;
  
  return qq{
    <ul class="tools">$tools<li class="last">$last</li></ul>
    <div class="more">
      <a href="#">More <span class="arrow">&#9660;</span></a>
    </div>
  };
}

1;

