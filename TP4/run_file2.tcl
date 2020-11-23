#On quitte la simulation en cours éventuelle
quit -sim

#directives de compilation des fichiers sources
vcom fifo.vhd
vcom testfifo.vhd

#lancement du simulateur (résolution de 1ns)
vsim -t 1ns work.test(bench)

#ajout des signaux dans la fenêtre de simulation
add wave -noupdate -divider {entrees du bloc operateur}
add wave -noupdate test/UUT/rst
add wave -noupdate test/UUT/H
add wave -noupdate test/UUT/Rw
add wave -noupdate test/UUT/enable
add wave -noupdate -radix binary -radixshowbase 0 test/UUT/dataIn

add wave -noupdate -divider {sortie du bloc operateur}
add wave -noupdate test/UUT/empty
add wave -noupdate test/UUT/full
add wave -noupdate -radix binary -radixshowbase 0 test/UUT/dataOut

#simulation de ns
run 500 ns
