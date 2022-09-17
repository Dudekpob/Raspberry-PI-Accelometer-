from sense_hat import SenseHat
sense = SenseHat()
import time
import random
import datetime

file = open('accdata.txt', 'a')  

def FillFile(x, y, z):
    t = datetime.datetime.now()
    time.sleep(1)
    x = str(x)
    y = str(y)
    z = str(z)
    list = [x, y, z]
    file.write(str(t))
    file.write(str('   ' + list[0] + '   ' + list[1] + '   ' + list[2] + '\n'))

dice = ['1', '2', '3', '4', '5', '6']

sense.clear()

while True:
    x, y, z = sense.get_accelerometer_raw().values()
    x = abs(x)
    y = abs(y)
    z = abs(z)
    FillFile(x, y, z)
    if x > 2 or y > 2 or z > 2:
        sense.show_letter(random.choice(dice), text_colour = (255, 0, 0))
        for i in range (0, 2):
            FillFile(x, y, z)    
        #time.sleep(2)
        sense.clear()
