import getpass
from fabric import Connection, Config

def establish_ssh_connection(hostname_ssh, user_ssh, port_ssh, password_ssh):
    # Establish SSH connection
    connect_kwargs = {'password': password_ssh}
    con_ssh = Connection(hostname_ssh, user=user_ssh, port=port_ssh, connect_kwargs=connect_kwargs)
    return con_ssh

def main():
    con_ssh = None

    hostname_ssh = "185.87.252.240"
    user_ssh = "scuser"
    port_ssh = 22666

    try:
        # Get password securely
        password_ssh = getpass.getpass("Enter SSH password: ")

        # Establish SSH connection
        con_ssh = establish_ssh_connection(hostname_ssh, user_ssh, port_ssh, password_ssh)

        # Run sudo commands on the remote server
        result = con_ssh.sudo("hostnamectl", hide=False)
        result1 = con_ssh.sudo("ls -la", hide=False)

        print(result.stdout)
        print(result1.stdout)

    except KeyboardInterrupt:
        print("Session interrupted by you!")

    except Exception as e:
        print(f"Error: {e}")

    finally:
        if con_ssh:
            # Close the SSH connection
            con_ssh.close()

if __name__ == "__main__":
    main()