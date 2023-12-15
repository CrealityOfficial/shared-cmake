import logging
import tempfile

def create_log(name):
    logger = logging.getLogger(name)
    logger.setLevel(logging.DEBUG)
    handler1 = logging.StreamHandler()
    
    dir_name = tempfile.mkdtemp(suffix=name, prefix='python_log_')
    #文件输出
    file_name = '{0}/{1}.log'.format(str(dir_name), name)
    handler2 = logging.FileHandler(filename=file_name,mode='w')

    fmt1 = logging.Formatter(fmt="%(levelname)-9s - %(filename)-8s : %(lineno)s line - %(message)s")
    
    fmt2 = logging.Formatter(fmt="%(asctime)s - %(name)s - %(levelname)-9s - %(filename)-8s : %(lineno)s line - %(message)s"
                        ,datefmt="%Y/%m/%d %H:%M:%S")
    
    handler1.setFormatter(fmt1)
    handler2.setFormatter(fmt2)
    logger.addHandler(handler1)
    logger.addHandler(handler2)

    logger.info('create_log in {}'.format(file_name))
    return logger
    