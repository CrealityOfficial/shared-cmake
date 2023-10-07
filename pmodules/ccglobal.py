import pw_trimesh

class Tracer(pw_trimesh.TTracer):
    #def __init__(self):
    #    super(pw_trimesh.TTracer, self).__init__()
        
    def progress(self, r):
        print("{}".format(r))
        
    def interrupt(self):
        return False
        
    def message(self, msg):
        print("{}".format(msg))
        
    def failed(self, msg):
        print(msg)
        
    def success(self):
        pass
