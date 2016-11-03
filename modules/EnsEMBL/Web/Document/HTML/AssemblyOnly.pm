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

=head1 MODIFICATIONS

Copyright [2014-2015] University of Edinburgh

All modifications licensed under the Apache License, Version 2.0, as above.

=cut

package EnsEMBL::Web::Document::HTML::AssemblyOnly;

use strict;

use base qw(EnsEMBL::Web::Document::HTML);

sub render {
  my $self      = shift;
  my $fragment  = shift eq 'fragment';
  my $full_list = $self->render_species_list($fragment);

  my $html = $fragment ? $full_list : sprintf('
      <div class="reorder_species" style="display: none;">
         %s
      </div>
      <div class="full_species">
        %s
      </div>
  ', $self->render_ajax_reorder_list, $full_list);


  #warn $html;

  return $html;
}



sub render_species_list {
  my ($self, $fragment) = @_;
  my $hub           = $self->hub;
  my $logins        = $hub->users_available;
  my $user          = $hub->user;
  my $species_info  = $hub->get_species_info;

  my (%check_extra,  @ok_extra);

  foreach (@{$hub->get_species_set('ASSEMBLY_ONLY')}) {
    next unless $species_info->{$_};
    push @ok_extra, $species_info->{$_} unless $check_extra{$_}++;
    #push @{$assemblies{$species_info->{$_}->{'scientific'}}}, $species_info->{$_};
  }
  #my $extra_html = $self->render_with_images(\@ok_extra,\%assemblies);
  my $html;
  if (@ok_extra){
    my $extra_html = $self->render_plain(@ok_extra);
    $html = qq{<div class="lb-info-box"><h3 class="lb-heading">Assemblies without gene models</h3><div class="lb-extra-assemblies">$extra_html</div></div>};
  }
  return $html;
}

sub render_plain {
  my ($self, @species_list) = @_;
  my $hub           = $self->hub;
  my $species_defs  = $hub->species_defs;
  my $static_server = $species_defs->ENSEMBL_STATIC_SERVER;
  my $html;

  foreach (@species_list) {
    $html .= qq(
      <div class="lb-extra-species-box">
        <a href="$_->{'key'}/Info/Index">
          $_->{'common'}
        </a>
      </div>
    );
  }

  return $html;
}

sub render_ajax_reorder_list {
  my $self          = shift;
  my $hub           = $self->hub;
  my $species_defs  = $hub->species_defs;
  my $favourites    = $hub->get_favourite_species;
  my %species_info  = %{$hub->get_species_info};
  my @fav_list      = map qq\<li id="favourite-$_->{'key'}">$_->{'common'} (<em>$_->{'scientific'}</em>)</li>\, map $species_info{$_}, @$favourites;

  delete $species_info{$_} for @$favourites;

  my @sorted       = sort { $a->{'common'} cmp $b->{'common'} } values %species_info;
  my @species_list = map qq\<li id="species-$_->{'key'}">$_->{'common'} (<em>$_->{'scientific'}</em>)</li>\, @sorted;

  return sprintf('
    <p>For easy access to commonly used genomes, drag from the bottom list to the top one &middot; <span class="link toggle_link">Save</span></p>
    <p><strong>Favourites</strong></p>
    <ul class="favourites list">
      %s
    </ul>
    <p><strong>Other available species</strong></p>
    <ul class="species list">
      %s
    </ul>
    <p><span class="link toggle_link">Save selection</span> &middot; <a href="/Account/Favourites/Reset">Restore default list</a></p>
  ', join("\n", @fav_list), join("\n", @species_list));
}

sub render_with_images {
  my ($self, $species_list, $assemblies) = @_;
  my $hub           = $self->hub;
  my $species_defs  = $hub->species_defs;
  my $static_server = $species_defs->ENSEMBL_STATIC_SERVER;
  my $html;



  foreach (@$species_list) {
    my $links = '<br/><span class="lb-alternate-assemblies">';
    foreach my $asm (@{$assemblies->{$_}}){
      $links .= qq(<a class="lb-alternate-assemblies" href="$asm->{'key'}/Info/Index">$asm->{'assembly'}</a>
      );
    }
    $links .= '</span>';
    $html .= qq(
      <div class="lb-species-box lb-secondary">
        <a href="$assemblies->{$_}[0]->{'key'}/Info/Index">
          <div class="lb-sp-img"><img src="$static_server/i/species/48/$assemblies->{$_}[0]->{'key'}.png" alt="$assemblies->{$_}[0]->{'name'}" title="Browse $assemblies->{$_}[0]->{'name'}" height="48" width="48" /></div>
        </a>
        <a class="lb-primary-assembly" href="$assemblies->{$_}[0]->{'key'}/Info/Index">
          $assemblies->{$_}[0]->{'scientific'}
        </a>
        $links
      </div>
    );
  }

  return $html;
}

1;