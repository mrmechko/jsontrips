import pkg_resources

def get_file(name):
    return open(pkg_resources.resource_string(__name__, name))
