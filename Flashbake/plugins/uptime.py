import subprocess
from flashbake.plugins import AbstractMessagePlugin

class Uptime(AbstractMessagePlugin):
    """ System Uptime plugin. """

    def addcontext(self, message_file, config):
        """ Just call uptime(1). """

        message_file.write("Uptime: "+ 
                            subprocess.Popen(
                              [
                                  "uptime", 
                              ], 
                              stdout=subprocess.PIPE
                            ).communicate()[0]
                          )
