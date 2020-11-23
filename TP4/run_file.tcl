#On quitte la simulation en cours éventuelle
quit -sim

#directives de compilation des fichiers sources
vcom cell.vhd
vcom operateur.vhd
vcom testop.vhd

#lancement du simulateur (résolution de 1ns)
vsim -t 1ns work.test(bench)

#ajout des signaux dans la fenêtre de simulation
add wave -noupdate -divider {entrees du bloc operateur}
add wave -noupdate -radix unsigned -radixshowbase 0 test/UUT/An
add wave -noupdate -radix unsigned -radixshowbase 0 test/UUT/Bn
add wave -noupdate -radix binary -radixshowbase 0 test/UUT/S
add wave -noupdate test/UUT/Cin

add wave -noupdate -divider {sortie du bloc operateur}
add wave -noupdate -radix unsigned -radixshowbase 0 test/UUT/Gn

#simulation de ns
run 100 ns