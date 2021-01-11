import os
from PIL import Image
import numpy as np
from scipy import misc
import subprocess
from skimage.transform import warp_coords, warp
from skimage.io import imsave, imread
from scipy.ndimage import map_coordinates
from shutil import copyfile
from multiprocessing import Process
from depth2stereo import *

batch1 = []
#batch2 = []

start_time = time.time()

for i in range(0,10,1):
    test=f'{i}'
    #depth=Image.open(f'dp{i}.jpg')
    batch1.append(Process(target=generate_stereo_pair, args=(test)))
    batch1[i].start()

for i in range(0,10,1):
    batch1[i].join()

print("--- %s seconds ---" % (time.time() - start_time))
#for i in range(10,20,1):
#    test=Image.open(f'{i}.jpg')
#    depth=Image.open(f'dp{i}.jpg')
#    batch2.append(Process(target=generate_stereo_pair, args=(test, depth, 1.5,i)))
#    batch2[i].start()

#for i in range(10,20,1):
#    batch2[i].join()

#for i in range(20,30,1):
#    test=Image.open(f'{i}.jpg')
#    depth=Image.open(f'dp{i}.jpg')
#    batch3.append(Process(target=generate_stereo_pair, args=(test, depth, 1.5,i)))
#    batch3[i].start()
#
#for i in range(20,30,1):
#    batch3[i].join()
