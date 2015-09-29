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

package EG::LepBase::SiteDefs;
use strict;

sub update_conf {
    $SiteDefs::ENSEMBL_PORT           = 8080;

## BEGIN LEPBASE MODIFICATIONS...
    $SiteDefs::ENSEMBL_SERVERNAME     = 'localhost.localdomain';
## ...END LEPBASE MODIFICATIONS

    map {delete($SiteDefs::__species_aliases{$_}) } keys %SiteDefs::__species_aliases;

## BEGIN LEPBASE MODIFICATIONS...
    $SiteDefs::ENSEMBL_PRIMARY_SPECIES  = 'Heliconius_melpomene'; # Default species
    $SiteDefs::ENSEMBL_SECONDARY_SPECIES  = 'Melitaea_cinxia'; # Default species
    $SiteDefs::__species_aliases{ 'Heliconius_melpomene' }   = [qw(Heliconius%20melpomene%20PRJEA71053 Heliconius%20melpomene)];    
    $SiteDefs::__species_aliases{ 'Danaus_plexippus' }       = [qw(Danaus%20plexippus%20PRJNA72423 Danaus%20plexippus)];    
    $SiteDefs::__species_aliases{ 'Bombyx_mori' }           = [qw(Bombyx%20mori%20PRJNA205630 Bombyx%20mori)];    
    $SiteDefs::__species_aliases{ 'Melitaea_cinxia' }       = [qw(Melitaea%20cinxia%20PRJNA191594 Melitaea%20cinxia)];
    $SiteDefs::__species_aliases{ 'Bicyclus_anynana_nba01' }= [qw(Bicyclus_anynana_nba01)];
    $SiteDefs::__species_aliases{ 'Chilo_suppressalis_csuogs1' }= [qw(Chilo_suppressalis_csuogs1)];
    $SiteDefs::__species_aliases{ 'Heliconius_melpomene_hmel2' }= [qw(Heliconius_melpomene_hmel2)];
    $SiteDefs::__species_aliases{ 'Lerema_accius_v1x1' }= [qw(Lerema_accius_v1x1)];
    $SiteDefs::__species_aliases{ 'Manduca_sexta_msex1' }= [qw(Manduca_sexta_msex1)];
    $SiteDefs::__species_aliases{ 'Papilio_glaucus_v1x1' }= [qw(Papilio_glaucus_v1x1)];
    $SiteDefs::__species_aliases{ 'Pieris_napi_das5' }= [qw(Pieris_napi_das5)];
    $SiteDefs::__species_aliases{ 'Plodia_interpunctella_v1' }= [qw(Plodia_interpunctella_v1)];
    $SiteDefs::__species_aliases{ 'Plutella_xylostella_dbmfjv1x1' }= [qw(Plutella_xylostella_dbmfjv1x1)];
    $SiteDefs::__species_aliases{ 'Heliconius_burneyi_helico2' }= [qw(Heliconius_burneyi_helico2)];

## ...END LEPBASE MODIFICATIONS
    @SiteDefs::ENSEMBL_PERL_DIRS    = (
                                           $SiteDefs::ENSEMBL_WEBROOT.'/perl',
                                           $SiteDefs::ENSEMBL_SERVERROOT.'/eg-web-common/perl',
                                           $SiteDefs::ENSEMBL_SERVERROOT.'/eg-web-metazoa/perl',
				       );

## BEGIN LEPBASE MODIFICATIONS...
    $SiteDefs::SITE_NAME = 'LepBase';
    $SiteDefs::ENSEMBL_SITETYPE = 'LepBase';
## ...END LEPBASE MODIFICATIONS
    $SiteDefs::SITE_FTP= 'ftp://ftp.ensemblgenomes.org/pub/metazoa';
    push @SiteDefs::ENSEMBL_HTDOCS_DIRS,  $SiteDefs::ENSEMBL_SERVERROOT.'/../biomarts/metazoa/biomart-perl/htdocs';
    
    $SiteDefs::DOCSEARCH_INDEX_DIR = $SiteDefs::ENSEMBL_SERVERROOT.'/eg-web-metazoa/data/docsearch';

    $SiteDefs::ENA_COLLECTION_ID = 223;

    $SiteDefs::ENA_SAMPLE_SEQ = "MSLKPKIVEFVDVWPRLRCIAESVITLTKVERSVWNTSFSDVYTLCVAQPEPMADRLYGETKHFLEQHVQEMLAKKVLIEGECSHSNGGPDLLQRYYITWMEYSQGIKYLHQLYIYLNQQHIKKQKITDTESFYGNLSSDAAEQMEIGELGLDIWRLYMIEYLSSELVRHILEGIAADRASNGTLDHHRVQIINGVIHSFVEVQDYKKTGSLKLYQELFEGPMLEASGAYYTDEANKLLHRCSVSEYMQEVIRILEYESRRAQKFLHVSSLPKLRKECEEKFINDRLGFIYSECREMVSEERRQDLRNMYVVLKPIPDNLKSELITTFLDHIKSEGLQTVSALKGENIHIAFVENMLKVHHKYQELIADVFENDSLFLSALDKACASVINRRPTERQPCRSAEYVAKYCDTLLKKSKTCEAEIDQKLTNNITIFKYIEDKDVYQKFYSRLLAKRLIHEQSQSMDAEEGMINRLKQACGYEFTNKLHRMFTDISVSVDLNNKFNTHLKDSNVDLGINLAIKVLQAGAWPLGSTQVIPFAVPQEFEKSIKMFEDYYHKLFSGRKLTWLHHMCHGELKLSHLKKSYIVTMQTYQMAIILLFETCDSLSCREIQNTLQLNDETFQKHMQPIIESKLLNASSENLAGETRIELNLDYTNKRTKFK";

}

1;
