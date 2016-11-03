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

Copyright [2014-2016] University of Edinburgh

All modifications licensed under the Apache License, Version 2.0, as above.

=cut

package EnsEMBL::Web::Component::Shared;

use strict;

##################################
### BEGIN LEPBASE MODIFICATIONS...
##################################
sub sequenceserver_button {
    my $self = shift;
    my ($title,$sequence,$label) = @_;
    my $blast_url = $self->hub->species_defs->BLAST_URL;
    my $button = '
        <form id="nt_blast_form_'.$label.'" target="_blank" action="'.$blast_url.'" method="POST">
            <input type="hidden" name="input_sequence" value=">'.$title."\n".$sequence.'">
            '.sequenceserver_link($title,$sequence,$label).'
        </form>';

    return $button;
}

sub sequenceserver_link {
    my ($title,$sequence,$label) = @_;
    my $link = '<a href="#" onclick="document.getElementById(\'nt_blast_form_'.$label.'\').submit();" class="button toggle no_img" style="float:left" title="Click to BLAST against Lepidoptera genes and genomes (opens a new window)">'.$label.'</a>';
    return $link;
}

##################################
### ...END LEPBASE MODIFICATIONS
##################################
1;
