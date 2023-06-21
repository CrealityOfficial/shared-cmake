import paramiko

def createSftpDir(sftp, remotePath):
    index = 0
    while True:
        pathIndex = remotePath.index('/', index + 1)
        if index <= pathIndex:
            index = pathIndex
            path = remotePath[0:pathIndex]
            try:
                sftp.stat(path)
                pass
            except Exception as e:
                sftp.mkdir(path)

        if pathIndex >= remotePath.rindex('/'):
            break

def createSFTP(ip, port, userName, userPassword):
    sf = paramiko.Transport((ip, port))
    sf.connect(username=userName, password=userPassword)
    sftp = paramiko.SFTPClient.from_transport(sf)
    return sftp

def createCXSFTP():
    sftpIp = '172.20.180.14'
    sftpPort = 22
    sftpUsername = 'bianyongfang'
    sftpPassword = 'yongfang111'

    return createSFTP(sftpIp, sftpPort, sftpUsername, sftpPassword)

def putFile(sftp, localName, remoteName):
    createSftpDir(sftp, remoteName)
    sftp.put(localName, remoteName)

def getFile(sftp, remoteName, localName):
    sftp.get(remoteName, localName)