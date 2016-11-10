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
  my $html = $self->render_species_list($fragment);

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

1;
