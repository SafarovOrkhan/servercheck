import getpass
from fabric import Connection, Config

def establish_ssh_connection():
    # Remote server details
    hostname_ssh = "185.87.252.240"
    user_ssh = "scuser"
    port_ssh = 22666

    # Get password securely
    password_ssh = getpass.getpass("Enter SSH password: ")

    # Set up configuration with sudo password
    config = Config(overrides={'sudo': {'password': password_ssh}})

    # Establish SSH connection
    connect_kwargs = {'password': password_ssh}
    con_ssh = Connection(hostname_ssh, user=user_ssh, port=port_ssh, config=config, connect_kwargs=connect_kwargs)

    return con_ssh

def main():
    # Establish SSH connection
    con_ssh = establish_ssh_connection()

    try:
        # Run a command on the remote server
        result = con_ssh.run("hostnamectl", hide=True)
        result2 = con_ssh.run("ls -la", hide=true )
        
        # Print the command output
        print(result.stdout)
        print(result2.stdout)
    finally:
        # Close the SSH connection
        con_ssh.close()

if __name__ == "__main__":
    main()

