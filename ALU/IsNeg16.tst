// This file is part of the materials accompanying the book 
// "The Elements of Computing Systems" by Nisan and Schocken, 
// MIT Press. Book site: www.idc.ac.il/tecs
// File name: projects/01/IsNeg16.tst

load IsNeg16.hdl,
output-file IsNeg16.out,
compare-to IsNeg16.cmp,
output-list in%B1.16.1 out%B3.1.3;

set in %B0000000000000000,
eval,
output;

set in %B1111111111111111,
eval,
output;

set in %B0110111011110111,
eval,
output;

set in %B1011011101101111,
eval,
output;

set in %B1000000000000000,
eval,
output;
