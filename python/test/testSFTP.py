import sys;

if __name__ == '__main__':
    directory = sys.path[0]
    sys.path.append(sys.path[0] + '/../')

    import SFTP
    sftp = SFTP.createCXSFTP()

    import PathUtil
    
    dir = sys.argv[1]
    remoteSub = sys.argv[2]
    
    fileNames = PathUtil.dirFileNames(dir)
    
    for fileName in fileNames:
        localFile = dir + '/' + fileName
        remoteFile = remoteSub + '/' + fileName
        print(localFile + ' --> ' + remoteFile)
        
        SFTP.putFile(sftp, localFile, remoteFile)