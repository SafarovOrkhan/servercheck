import fabric
import getpass

from fabric import Connection , Config
hostnameSSH = "185.87.252.240"
userSSH = "scuser"
portSSH = 22666

passwordSSH = getpass.getpass()

config = Config(overrides={'sudo': {'password' : passwordSSH}})
conSSH = Connection(hostnameSSH, user=userSSH, port=portSSH, config=config)

conSSH.run("hostnamectl")
