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

Copyright [2014-2016] University of Edinburgh

All modifications licensed under the Apache License, Version 2.0, as above.

=cut

package EnsEMBL::Web::Document::Element::SearchBox;

### Generates small search box (used in top left corner of pages)

use strict;

use base qw(EnsEMBL::Web::Document::Element);

## BEGIN LEPBASE MODIFICATIONS...
sub search_options {
  my $self          = shift;
  my $species       = $self->species;
  my $species_name  = $species ? $self->species_defs->SPECIES_COMMON_NAME : '';
  my $sitename = $self->species_defs->SITE_NAME || 'multi';

 return [
    $self->hub->species ? (
    'ensemblthis'     => { 'label' => 'Search ' . $self->species_defs->SPECIES_COMMON_NAME, 'icon' => 'species/48/' . $self->hub->species . '.png'  }) : (
    'ensemblunit'     => { 'label' => "Search $sitename",       'icon' => 'e.png'      }),
  ];
}
## ...END LEPBASE MODIFICATIONS

sub content {
  my $self            = shift;
  my $img_url         = $self->img_url;
  my $species         = $self->species;
 ## BEGIN LEPBASE MODIFICATIONS...
  my $species_defs    = $self->species_defs;
  my $search_db_name  = $species_defs->SEARCH_DB_NAME;
  my $search_db_host  = $species_defs->SEARCH_DB_HOST;
  my $search_db_port  = $species_defs->SEARCH_DB_PORT;
  my $search_db_user  = $species_defs->SEARCH_DB_USER;
  my $search_table    = $species ? lc $species : 'multi';
  my $search_url      = sprintf '%s%s/psychic', $self->home_url, $species || 'Multi';
  my $options         = $self->search_options;
  my %options_hash    = @$options;
  my $search_code     = lc $self->default_search_code;
     $search_code     = $options->[0] unless exists $options_hash{$search_code};
  my $search_options  = join '', map {
    if ($_ % 2 == 0) {
      my $code    = $options->[$_];
      my $details = $options->[$_ + 1];
      qq(<div class="$code"><img src="${img_url}$details->{'icon'}" alt="$details->{'label'}"/>$details->{'label'}<input type="hidden" value="$details->{'label'}&hellip;" /></div>\n);
    }
  } 0..scalar @$options - 1;

  return qq(
    <div id="searchPanel" class="js_panel">
      <input type="hidden" class="panel_type" value="SearchBox" />
      <form id="searchbox_form">
        <div class="search print_hide">
          <div class="sites button">
            <img class="search_image" src="${img_url}$options_hash{$search_code}{'icon'}" alt="" />
            <!--img src="${img_url}search/down.gif" style="width:7px" alt="" />
            <input type="hidden" name="site" value="$search_code" /-->
          </div>
          <div>
            <label class="hidden" for="se_q">Search terms</label>
            <input class="query inactive" id="se_q" type="text" name="q" value="$options_hash{$search_code}{'label'}&hellip;" data-role="none" />
            <input type="hidden" id="search_table" name="table" value ="$search_table" />
            <input type="hidden" id="search_db_name" name="search_db_name" value ="$search_db_name" />
            <input type="hidden" id="search_db_host" name="search_db_host" value ="$search_db_host" />
            <input type="hidden" id="search_db_port" name="search_db_port" value ="$search_db_port" />
            <input type="hidden" id="search_db_user" name="search_db_user" value ="$search_db_user" />
          </div>
          <!--div class="button"><input type="image" src="${img_url}16/search.png" alt="Search&nbsp;&raquo;" /></div-->
        </div>
        <!--div class="site_menu hidden">
          $search_options
        </div-->
      </form>
    </div>
    <a href="/Multi/Search/New"><img src="/i/32/rev/search.png" title="Search this site" class="mobile-search mobile-only" /></a>
  );
## ...END LEPBASE MODIFICATIONS
}

1;
