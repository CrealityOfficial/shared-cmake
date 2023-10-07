import pw_trimesh

class Tracer(pw_trimesh.ccTracer):
    def __init__(self):
        pass
        
    def progress(self, r):
        pass
        
    def interrupt(self):
        return False
        
    def message(self, msg):
        print(msg)
        
    def failed(self, msg):
        print(msg)
        
    def success(self):
        pass
