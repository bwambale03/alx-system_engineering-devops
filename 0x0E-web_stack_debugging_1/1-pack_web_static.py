#!/usr/bin/python3
    """This generates a tgz archive from web_static folder"""
from fabric import task
import time

# additionally, this is syntax for fabric 3
@task
def do_pack(c):
    """This generates a tgz archive from web_static folder"""
    try:
        c.run("mkdir -p versions")
        c.run("tar -cvzf versions/web_static_{}.tgz web_static/"
              format(time.strftime("%Y%m%d%H%M%S")))
        return ("versions/web_static_{}.tgz".format(time.
                                                    strftime("%Y%m%d%H%M%S")))
    except:
        return None

