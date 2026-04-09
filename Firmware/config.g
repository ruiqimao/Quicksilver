; Configuration file for RepRapFirmware on Duet 3 Mini 5+ WiFi
; executed by the firmware on start-up

; XY motors: drivers 0 and 4
; Z motor: driver 3
; Extruder motor: driver 2
; Z endstop: io6
; Bed thermistor (Semitec 104-GT2): temp0
; Hotend RTD (PT1000): temp1
; Bed heater (LDO 100W polyimide bed): out0
; Hotend heater (60W): out1
; Sheet cooling fans: out3 and out4
; Hotend fan: out5

; General
G90 ; absolute coordinates
M83 ; relative extruder moves
M550 P"quicksilver" ; set hostname

; Network
M552 S1 ; configure WiFi adapter
M586 P0 S1 ; configure HTTP

; Smart Drivers
M569 P0.0 S1 D2 ; driver 0.0 goes forwards (Y axis)
M569 P0.2 S0 D2 ; driver 0.2 goes backwards (extruder 0)
M569 P0.3 S1 D3 V4000 ; driver 0.3 goes forwards (Z axis)
M569 P0.4 S1 D2 ; driver 0.4 goes forwards (X axis)

; Motor Idle Current Reduction
M906 I30 ; set motor current idle factor
M84 S30 ; set motor current idle timeout

; Axes
M584 X0.4 Y0.0 Z0.3 ; set axis mapping
M350 X16 Y16 Z16 I1 ; configure microstepping with interpolation
M906 X2000 Y2000 Z1000 ; set axis driver currents
M92 X80 Y80 Z400 ; configure steps per mm
M208 X0:120 Y-3:120 Z0:101.07 ; set minimum and maximum axis limits
M566 X3600 Y3600 Z3000 ; set maximum instantaneous speed changes (mm/min)
M203 X30000 Y30000 Z2400 ; set maximum speeds (mm/min)
M201 X30000 Y30000 Z300 ; set accelerations (mm/s^2)

; Extruders
M584 E0.2 ; set extruder mapping
M350 E16 I1 ; configure microstepping with interpolation
M906 E1000 ; set extruder driver currents
M92 E1192.59 ; configure steps per mm
M566 E3600 ; set maximum instantaneous speed changes (mm/min)
M203 E3600 ; set maximum speeds (mm/min)
M201 E1500 ; set accelerations (mm/s^2)

; Kinematics
M669 K1 ; configure CoreXY kinematics

; Endstops
M574 X2 S4 ; configure X axis endstop
M574 Y2 S4 ; configure Y axis endstop
M574 Z2 S1 P"io6.in" ; configure Z axis endstop

; Sensors
M308 S0 P"temp0" Y"thermistor" A"Bed" T100000 B4388 C7.06e-8 ; configure sensor #0
M308 S1 P"temp1" Y"pt1000" A"Hotend" ; configure sensor #1

; Heaters
M950 H0 C"out0" T0 ; create heater #0 (bed)
M143 H0 P0 T0 C0 S120 A0 ; configure heater monitor #0 for heater #0
M307 H0 R0.285 K0.611:0.000 D2.04 E1.35 S1.00 B0 V24.0 ; configure model of heater #0
M950 H1 C"out1" T1 ; create heater #1 (hotend)
M143 H1 P0 T1 C0 S500 A0 ; configure heater monitor #0 for heater #1
M307 H1 R3.039 K0.583:0.000 D4.85 E1.35 S1.00 B0 V24.0

; Heated beds
M140 P0 H0 ; configure heated bed #0

; Fans
M950 F0 C"!out3+out3.tach" K4 ; create fan #1
M106 P0 C"Right" S0 L0.2 X1 B0.1 ; configure fan #1
M950 F1 C"!out4+out4.tach" K4 ; create fan #2
M106 P1 C"Left" S0 L0.2 X1 B0.1 ; configure fan #2
M950 F2 C"out5" ; create fan #3
M106 P2 C"Hotend" S1 B0.1 H1 T45 ; configure fan #3

; Tools
M563 P0 D0 H1 F0:1 ; create tool #0
M568 P0 R0 S0 ; set initial tool #0 active and standby temperatures to 0C

; Miscellaneous
M915 X Y R0 F0 S15 ; sensorless homing sensitivity
T0 ; select first tool
M302 P1 ; allow cold extrudes
M593 P"mzv" F100.0 ; input shaping
