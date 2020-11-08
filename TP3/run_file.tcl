#On quitte la simulation en cours éventuelle
quit -sim

#directives de compilation des fichiers sources
vcom multiplication.vhd
vcom testmult.vhd

#lancement du simulateur (résolution de 1ns)
vsim -t 1ns work.test(bench)

#ajout des signaux dans la fenêtre de simulation
add wave -noupdate -divider {entrees du bloc multiplication}
add wave -noupdate -radix unsigned -radixshowbase 0 test/UUT/multiplieur
add wave -noupdate -radix unsigned -radixshowbase 0 test/UUT/multiplicande
add wave -noupdate test/UUT/clk
add wave -noupdate test/UUT/go

add wave -noupdate -divider {signaux internes}
add wave -noupdate test/UUT/rst
add wave -noupdate -radixshowbase 0 test/UUT/etat


add wave -noupdate -divider {sorties du bloc multiplication}
add wave -noupdate -radix unsigned -radixshowbase 0 test/UUT/s
add wave -noupdate test/UUT/fin

#simulation de ns
run 200 ns
