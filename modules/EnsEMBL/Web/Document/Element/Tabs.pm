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

# $Id: Tabs.pm,v 1.4 2012-12-17 14:18:30 nl2 Exp $

package EnsEMBL::Web::Document::Element::Tabs;


## BEGIN LEPBASE MODIFICATIONS...

sub old_species_list {
  my $self      = shift;

  my $html;
  foreach my $sp (@{$self->{'species_list'}}) {
## BEGIN LEPBASE MODIFICATIONS...
    $html .= qq{<li><a class="constant" href="$sp->[0]">$sp->[2]</a></li>} unless $sp->[1] =~ m/helico[12]$/;
## ..END LEPBASE MODIFICATIONS
  }
  
  return qq{<div class="dropdown species"><h4>Select a species</h4><ul>$html</ul></div>};
}



sub species_list {
  my $self = shift;
  
  my $hub           = $self->hub;
  my $species_info  = $hub->get_species_info;
  
  my (@ok_faves, %check_faves);
  
  foreach (@{$hub->get_favourite_species}) {
    push @ok_faves, [$species_info->{$_}->{'url'},$species_info->{$_}->{'scientific'}] unless $check_faves{$species_info->{$_}->{'scientific'}}++;
  }
  my $html;
  foreach my $sp (@ok_faves) {
    $html .= qq{<li><a class="constant" href="$sp->[0]">$sp->[1]</a></li>};
  }
  
  return qq{<div class="dropdown species"><h4>Select a species</h4><ul>$html</ul></div>};
}
## ..END LEPBASE MODIFICATIONS

1;
