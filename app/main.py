#example for base
import time


print("dev-python -- version -- 0.0.11 launched")

time.sleep(1)

for i in range(20):
    print(time.strftime("%Y-%m-%d %H:%M:%S"))
    print(" PROGRESS 100 "+str(float(i*5)))
    time.sleep(1)





