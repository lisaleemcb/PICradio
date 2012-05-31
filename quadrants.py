from math import sin, pi

datatab = open('table_asm.dat','w')
waveform = open('testwave.dat','w')

lut = [128*sin(pi/2*x/64) + 128 for x in range(0,64)]

for i in range(0,len(lut)):
	if i % 8 == 0:
		datatab.write("\n" + "\tdt\t")
	datatab.write(str(hex(int(abs(lut[i])))) + ",")

init = 0b00000000
for it in range(1,1024):
	idx = init & 0b00111111
	msbs = init & 0b11000000
	val = 0
	if msbs == 0:
		val = lut[idx]
	elif msbs == 64:
		val = lut[0b00111111 - idx]
	elif msbs == 128:
		val = 256 - lut[idx]
	elif msbs == 192:
		val = 256 - lut[0b00111111 - idx]
	waveform.write(str(abs(int(val))) + "\n")
	init += 0b11