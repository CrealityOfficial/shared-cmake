import subprocess
import sys
import os

def _decode_data(byte_data: bytes):
    try:
        return byte_data.decode('UTF-8')
    except UnicodeDecodeError:
        return byte_data.decode('GB18030')

def run_system(cmd, logger=None):
    return os.system(cmd) == 0
    
def run_subprocess(cmd, logger=None):
    p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    
    if not logger == None:
        while p.poll() is None:
            line = p.stdout.readline().rstrip()
            if line:
                line = _decode_data(line)
                logger.info(line)

    return True if p.returncode == 0 else False
    
def run(cmd, forceExit=False, logger=None):
    if not logger == None:
        logger.info('Run: {0}'.format(cmd))
    
    result = True
    if True:
        result = run_system(cmd, logger)
    else:
        result = run_subprocess(cmd, logger)

    if not logger == None:
        if result:
            logger.info('RUN SUCCESS.\n')
        else:
            logger.error('RUN FAILED.\n')
            
    if result == False and forceExit:       
        sys.exit(2)
        
    return result
        
    