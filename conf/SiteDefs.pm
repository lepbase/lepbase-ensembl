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
## ...END LEPBASE MODIFICATIONS


# --- Release 12
#    $SiteDefs::__species_aliases{ 'Tribolium_castaneum' } = [qw(Tribolium_castaneum)];
#    $SiteDefs::__species_aliases{ 'Bombyx_mori_PRJDA20217' } = [qw(Bombyx_mori_PRJDA20217)];
#    $SiteDefs::__species_aliases{ 'Atta_cephalotes' } = [qw(Atta_cephalotes)];

# --- Release 14
#    $SiteDefs::__species_aliases{ 'Danaus_plexippus_PRJNA72423' } = [qw(danaus_plexippus_PRJNA72423)];    
#    $SiteDefs::__species_aliases{ 'Heliconius_melpomene_PRJEA71053' } = [qw(heliconius_melpomene_PRJEA71053)];    
#    $SiteDefs::__species_aliases{ 'Heliconius_melpomene' } = [qw(heliconius_melpomene)];    

# --- Release 23
#    $SiteDefs::__species_aliases{'Mnemiopsis_leidyi'} = [qw(Mnemiopsis_leidyi)];
#    $SiteDefs::__species_aliases{'Melitaea_cinxia_PRJNA191594'} = [qw(Melitaea_cinxia_PRJNA191594)];

# --- Lepbase release 1
## BEGIN LEPBASE MODIFICATIONS...
#    $SiteDefs::__species_aliases{'Plutella_xylostella_PRJNA78271'} = [qw(plutella_xylostella_PRJNA78271)];
#    $SiteDefs::__species_aliases{'Plodia_interpunctella_PRJEB4874'} = [qw(plodia_interpunctella PRJEB4874)];
#    $SiteDefs::__species_aliases{'Bicyclus_anynana_PRJEB8426'} = [qw(bicyclus_anynana PRJEB8426)];
#    $SiteDefs::__species_aliases{'Manduca_sexta_PRJNA71235'} = [qw(manduca_sexta_PRJNA71235)];
#    $SiteDefs::__species_aliases{'Chilo_suppressalis_PRJNA178139'} = [qw(chilo_suppressalis_PRJNA178139)];
#    $SiteDefs::__species_aliases{'Pieris_napi_LBTMP10001'} = [qw(pieris_napi_LBTMP10001)];
    $SiteDefs::__species_aliases{ 'Heliconius_melpomene_PRJEA71053' }   = [qw(Heliconius%20melpomene%20PRJEA71053 Heliconius%20melpomene)];    
    $SiteDefs::__species_aliases{ 'Danaus_plexippus_PRJNA72423' }       = [qw(Danaus%20plexippus%20PRJNA72423 Danaus%20plexippus)];    
    $SiteDefs::__species_aliases{ 'Bombyx_mori_PRJNA205630' }           = [qw(Bombyx%20mori%20PRJNA205630 Bombyx%20mori)];    
    $SiteDefs::__species_aliases{ 'Melitaea_cinxia_PRJNA191594' }       = [qw(Melitaea%20cinxia%20PRJNA191594 Melitaea%20cinxia)];
    $SiteDefs::__species_aliases{ 'Heliconius_melpomene_LEPBA0003' }    = [qw(Heliconius%20melpomene%20LEPBA0003)];    
    $SiteDefs::__species_aliases{ 'Bicyclus_anynana_PRJEB8426' }        = [qw(Bicyclus%20anynana%20PRJEB8426 Bicyclus%20anynana)];    
    $SiteDefs::__species_aliases{ 'Chilo_suppressalis_PRJNA178139' }    = [qw(Chilo%20suppressalis%20PRJNA178139 Chilo%20suppressalis)];    
    $SiteDefs::__species_aliases{ 'Lerema_accius_LEPBA0002' }           = [qw(Lerema%20accius%20LEPBA0002 Lerema%20accius)];    
    $SiteDefs::__species_aliases{ 'Manduca_sexta_PRJNA81037' }          = [qw(Manduca%20sexta%20PRJNA81037 Manduca%20sexta)];    
    $SiteDefs::__species_aliases{ 'Papilio_glaucus_PRJNA270125' }       = [qw(Papilio%20glaucus%20PRJNA270125 Papilio%20glaucus)];    
    $SiteDefs::__species_aliases{ 'Pieris_napi_LEPBA0001' }             = [qw(Pieris%20napi%20LEPBA0001 Pieris%20napi)];    
    $SiteDefs::__species_aliases{ 'Plodia_interpunctella_PRJEB4874' }   = [qw(Plodia%20interpunctella%20PRJEB4874 Plodia%20interpunctella)];    
    $SiteDefs::__species_aliases{ 'Plutella_xylostella_PRJNA78271' }    = [qw(Plutella%20xylostella%20PRJNA78271 Plutella%20xylostella)];    
    $SiteDefs::__species_aliases{ 'Heliconius_numata_LEPBA0004' }       = [qw(Heliconius%20numata%20LEPBA0004,Heliconius%20numata)];    
    $SiteDefs::__species_aliases{ 'Heliconius_timareta_LEPBA0005' }     = [qw(Heliconius%20timareta%20LEPBA0005,Heliconius%20timareta)];    
    $SiteDefs::__species_aliases{ 'Heliconius_erato_LEPBA0006' }        = [qw(Heliconius%20erato%20LEPBA0006,Heliconius%20erato)];    

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
