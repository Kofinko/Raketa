use <configuration/sloupek.scad>
use <configuration/plbase.scad>
use <configuration/bocnice.scad>
use <configuration/spodni_kryt.scad>
use <configuration/otvory.scad>
use <configuration/text/Write.scad>
use <upravena_bocnice.scad>

include <configuration/manufactury_conf.scad>
include <configuration.scad>
include <configuration/otvory_conf.scad>


barva_dno_bocnice = "cyan";
barva_spodni_kryt = "green";
barva_plbase_horni = "yellow";

posuv_dilu=20; //pro složeni krabičky zadat 0 pro rozebrání zdat 10

//BOCNICE SE DNEM
//-------------------------------------------------------------


color(barva_dno_bocnice)
    upravena_bocnice();

//PLBASE HORNI
//-------------------------------------------------------------
translate([0,0,5*posuv_dilu])
color(barva_plbase_horni)
translate([0,0,vyska_bocnice/2])
    rotate(a=[0,0,0])
    { 
        plbase_vrchni_kryt_pro_odecet(pocet_der1-1,pocet_der2-1,radidus_hrany,vzdalenost_der,vzdalenost_od_okraje,prumer_sroubu,vyska_bocnice,prekryti_der,tloustka_bocnice,plbase_tolerance_horni,tloustka_plbase);    
    }

//SPODNÍ KRYT
//-------------------------------------------------------------
/*translate([0,0,-5*posuv_dilu])
color(barva_spodni_kryt)
translate([0,0,-vyska_bocnice/2-2*tloustka_plbase])
    spodni_kryt(pocet_der1-1,pocet_der2-1,radidus_hrany,vzdalenost_der,vzdalenost_od_okraje,prumer_sroubu,vyska_bocnice,prekryti_der,tloustka_bocnice);
*/






