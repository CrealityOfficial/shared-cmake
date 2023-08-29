import sys;
sys.path.append(sys.path[0] + '/../python/')

import autoTest

print("algrithm auto check")
print("autoTest origin_path: " + autoTest.origin_path)
print("autoTest bin_path: " + autoTest.bin_path)

sys.path.append(origin_path)
import demo.test
    

    
    
    
    



