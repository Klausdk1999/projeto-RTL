onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_mdc/i_CLK
add wave -noupdate /tb_mdc/i_RSTn
add wave -noupdate /tb_mdc/i_GO
add wave -noupdate -radix unsigned /tb_mdc/i_X
add wave -noupdate -radix unsigned /tb_mdc/i_Y
add wave -noupdate -radix unsigned /tb_mdc/o_D
add wave -noupdate /tb_mdc/o_RDY
add wave -noupdate /tb_mdc/u_dut/i_CLK
add wave -noupdate /tb_mdc/u_dut/i_RSTn
add wave -noupdate /tb_mdc/u_dut/i_GO
add wave -noupdate /tb_mdc/u_dut/i_X
add wave -noupdate /tb_mdc/u_dut/i_Y
add wave -noupdate /tb_mdc/u_dut/o_D
add wave -noupdate /tb_mdc/u_dut/o_RDY
add wave -noupdate /tb_mdc/u_dut/w_Rx_ld
add wave -noupdate /tb_mdc/u_dut/w_Ry_ld
add wave -noupdate /tb_mdc/u_dut/w_Rx_clr
add wave -noupdate /tb_mdc/u_dut/w_Ry_clr
add wave -noupdate /tb_mdc/u_dut/w_Rx_sub_ld
add wave -noupdate /tb_mdc/u_dut/w_Ry_sub_ld
add wave -noupdate /tb_mdc/u_dut/w_X_eq_Y
add wave -noupdate /tb_mdc/u_dut/w_X_lt_Y
add wave -noupdate /tb_mdc/u_dut/w_D_out
add wave -noupdate /tb_mdc/u_dut/u_datapath/i_CLK
add wave -noupdate /tb_mdc/u_dut/u_datapath/i_RSTn
add wave -noupdate /tb_mdc/u_dut/u_datapath/i_X
add wave -noupdate /tb_mdc/u_dut/u_datapath/i_Y
add wave -noupdate /tb_mdc/u_dut/u_datapath/i_Rx_ld
add wave -noupdate /tb_mdc/u_dut/u_datapath/i_Ry_ld
add wave -noupdate /tb_mdc/u_dut/u_datapath/i_Rx_clr
add wave -noupdate /tb_mdc/u_dut/u_datapath/i_Ry_clr
add wave -noupdate /tb_mdc/u_dut/u_datapath/i_Rx_sub_ld
add wave -noupdate /tb_mdc/u_dut/u_datapath/i_Ry_sub_ld
add wave -noupdate /tb_mdc/u_dut/u_datapath/o_X_eq_Y
add wave -noupdate /tb_mdc/u_dut/u_datapath/o_X_lt_Y
add wave -noupdate /tb_mdc/u_dut/u_datapath/o_D_out
add wave -noupdate /tb_mdc/u_dut/u_datapath/r_X
add wave -noupdate /tb_mdc/u_dut/u_datapath/r_Y
add wave -noupdate /tb_mdc/u_dut/u_datapath/w_sub_x
add wave -noupdate /tb_mdc/u_dut/u_datapath/w_sub_y
add wave -noupdate /tb_mdc/u_dut/u_control/i_CLK
add wave -noupdate /tb_mdc/u_dut/u_control/i_RSTn
add wave -noupdate /tb_mdc/u_dut/u_control/i_GO
add wave -noupdate /tb_mdc/u_dut/u_control/i_X_eq_Y
add wave -noupdate /tb_mdc/u_dut/u_control/i_X_lt_Y
add wave -noupdate /tb_mdc/u_dut/u_control/o_Rx_ld
add wave -noupdate /tb_mdc/u_dut/u_control/o_Ry_ld
add wave -noupdate /tb_mdc/u_dut/u_control/o_Rx_clr
add wave -noupdate /tb_mdc/u_dut/u_control/o_Ry_clr
add wave -noupdate /tb_mdc/u_dut/u_control/o_Rx_sub_ld
add wave -noupdate /tb_mdc/u_dut/u_control/o_Ry_sub_ld
add wave -noupdate /tb_mdc/u_dut/u_control/o_RDY
add wave -noupdate /tb_mdc/u_dut/u_control/s_CUR
add wave -noupdate /tb_mdc/u_dut/u_control/s_NXT
add wave -noupdate /tb_mdc/u_dut/u_control/v_Rx_ld
add wave -noupdate /tb_mdc/u_dut/u_control/v_Ry_ld
add wave -noupdate /tb_mdc/u_dut/u_control/v_Rx_clr
add wave -noupdate /tb_mdc/u_dut/u_control/v_Ry_clr
add wave -noupdate /tb_mdc/u_dut/u_control/v_Rx_sub_ld
add wave -noupdate /tb_mdc/u_dut/u_control/v_Ry_sub_ld
add wave -noupdate /tb_mdc/u_dut/u_control/v_RDY
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {1601772 ps} {2543313 ps}
