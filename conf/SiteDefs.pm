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
    $SiteDefs::ENSEMBL_PRIMARY_SPECIES  = 'Heliconius_melpomene_hmel2'; # Default species
    $SiteDefs::ENSEMBL_SECONDARY_SPECIES  = 'Melitaea_cinxia'; # Default species

    $SiteDefs::__species_aliases{ 'Bombyx_mori' }           = [qw(bombyx_mori_core_27_80_1)];
    $SiteDefs::__species_aliases{ 'Danaus_plexippus' }       = [qw(danaus_plexippus_core_27_80_1)];
    $SiteDefs::__species_aliases{ 'Heliconius_melpomene' }   = [qw(heliconius_melpomene_hmel2_core_27_80_1)];
    $SiteDefs::__species_aliases{ 'Melitaea_cinxia' }       = [qw(melitaea_cinxia_core_27_80_1)];
    $SiteDefs::__species_aliases{ 'Amyelois_transitella_v1' }= [qw(amyelois_transitella_v1_core_27_80_2)];
    $SiteDefs::__species_aliases{ 'Bicyclus_anynana_v1x2' }= [qw(bicyclus_anynana_v1x2_core_27_80_2)];
    $SiteDefs::__species_aliases{ 'Bicyclus_anynana_nba01' }= [qw(bicyclus_anynana_nba01_core_27_80_1)];
    $SiteDefs::__species_aliases{ 'Bombyx_mori_asm15162v1' }= [qw(bombyx_mori_asm15162v1_core_27_80_2)];
    $SiteDefs::__species_aliases{ 'Chilo_suppressalis_csuogs1' }= [qw(chilo_suppressalis_csuogs1_core_27_80_2)];
    $SiteDefs::__species_aliases{ 'Danaus_plexippus_v3' }= [qw(danaus_plexippus_v3_core_27_80_2)];
    $SiteDefs::__species_aliases{ 'Heliconius_melpomene_hmel2' }= [qw(heliconius_melpomene_hmel2_core_27_80_2)];
    $SiteDefs::__species_aliases{ 'Lerema_accius_v1x1' }= [qw(lerema_accius_v1x1_core_27_80_2)];
    $SiteDefs::__species_aliases{ 'Manduca_sexta_msex1' }= [qw(manduca_sexta_msex1_core_27_80_2)];
    $SiteDefs::__species_aliases{ 'Operophtera_brumata_v1' }= [qw(operophtera_brumata_v1_core_27_80_2)];
    $SiteDefs::__species_aliases{ 'Papilio_glaucus_v1x1' }= [qw(papilio_glaucus_v1x1_core_27_80_2)];
    $SiteDefs::__species_aliases{ 'Papilio_machaon_papma1' }= [qw(papilio_machaon_papma1_core_27_80_2)];
    $SiteDefs::__species_aliases{ 'Papilio_polytes_ppol1' }= [qw(papilio_polytes_ppol1_core_27_80_2)];
    $SiteDefs::__species_aliases{ 'Papilio_xuthus_papxu1' }= [qw(papilio_xuthus_papxu1_core_27_80_2)];
    $SiteDefs::__species_aliases{ 'Papilio_xuthus_pxut1' }= [qw(papilio_xuthus_pxut1_core_27_80_2)];
    $SiteDefs::__species_aliases{ 'Plodia_interpunctella_v1' }= [qw(plodia_interpunctella_v1_core_27_80_2)];
    $SiteDefs::__species_aliases{ 'Plutella_xylostella_dbmfjv1x1' }= [qw(plutella_xylostella_dbmfjv1x1_core_27_80_2)];
    $SiteDefs::__species_aliases{ 'Spodoptera_frugiperda_v2' }= [qw(spodoptera_frugiperda_v2_core_27_80_2)];

    $SiteDefs::__species_aliases{ 'Agraulis_vanillae_helico2' }= [qw(agraulis_vanillae_helico2_core_27_80_1)];
    $SiteDefs::__species_aliases{ 'Eueides_tales_helico2' }= [qw(eueides_tales_helico2_core_27_80_1)];
    $SiteDefs::__species_aliases{ 'Heliconius_besckei_helico2' }= [qw(heliconius_besckei_helico2_core_27_80_1)];
    $SiteDefs::__species_aliases{ 'Heliconius_burneyi_helico2' }= [qw(heliconius_burneyi_helico2_core_27_80_1)];
    $SiteDefs::__species_aliases{ 'Heliconius_cydno_helico2' }= [qw(heliconius_cydno_helico2_core_27_80_1)];
    $SiteDefs::__species_aliases{ 'Heliconius_demeter_helico2' }= [qw(heliconius_demeter_helico2_core_27_80_1)];
    $SiteDefs::__species_aliases{ 'Heliconius_elevatus_helico2' }= [qw(heliconius_elevatus_helico2_core_27_80_1)];
    $SiteDefs::__species_aliases{ 'Heliconius_erato_helico2' }= [qw(heliconius_erato_helico2_core_27_80_1)];
    $SiteDefs::__species_aliases{ 'Heliconius_erato_himera_helico2' }= [qw(heliconius_erato_himera_helico2_core_27_80_1)];
    $SiteDefs::__species_aliases{ 'Heliconius_hecale_helico1' }= [qw(heliconius_hecale_helico1_core_27_80_1)];
    $SiteDefs::__species_aliases{ 'Heliconius_himera_helico1' }= [qw(heliconius_himera_helico1_core_27_80_1)];
    $SiteDefs::__species_aliases{ 'Heliconius_melpomene_helico2' }= [qw(heliconius_melpomene_helico2_core_27_80_1)];
    $SiteDefs::__species_aliases{ 'Heliconius_numata_helico2' }= [qw(heliconius_numata_helico2_core_27_80_1)];
    $SiteDefs::__species_aliases{ 'Heliconius_pardalinus_helico2' }= [qw(heliconius_pardalinus_helico2_core_27_80_1)];
    $SiteDefs::__species_aliases{ 'Heliconius_telesiphe_helico2' }= [qw(heliconius_telesiphe_helico2_core_27_80_1)];
    $SiteDefs::__species_aliases{ 'Heliconius_timareta_helico2' }= [qw(heliconius_timareta_helico2_core_27_80_1)];
    $SiteDefs::__species_aliases{ 'Laparus_doris_helico2' }= [qw(laparus_doris_helico2_core_27_80_1)];
    $SiteDefs::__species_aliases{ 'Neruda_aoede_helico2' }= [qw(neruda_aoede_helico2_core_27_80_1)];

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
