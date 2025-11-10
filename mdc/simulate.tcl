# ============================================
# Script de simulação do projeto MDC - ModelSim
# ============================================

# Limpa o ambiente anterior
vdel -all
vlib work
vmap work work

# Compilação em ordem hierárquica
vcom -2008 datapath.vhd
vcom -2008 control.vhd
vcom -2008 top_mdc.vhd
vcom -2008 tb_mdc.vhd

# Inicia a simulação
vsim work.tb_mdc

# Adiciona todos os sinais à janela de ondas
#add wave -r /*
do wave.do

# Roda a simulação por 2 microsegundos (ajuste conforme seu testbench)
run 2 us

# Mantém a janela aberta após a simulação
run -all
