import getpass
from fabric import Connection, Config

def establish_ssh_connection(hostname_ssh,user_ssh,port_ssh,password_ssh):
    # Establish SSH connection
    connect_kwargs = {'password': password_ssh}
    con_ssh = Connection(hostname_ssh, user=user_ssh, port=port_ssh,connect_kwargs=connect_kwargs)
    return con_ssh

def main():

    hostname_ssh = "185.87.252.240"
    user_ssh = "scuser"
    port_ssh = 22666
    # Get password securely
    try:
        password_ssh = getpass.getpass("Enter SSH password: ")
    except KeyboardInterrupt:
        print("Session interrupted by you!")
    finally:
        # Establish SSH connection
        con_ssh = establish_ssh_connection(hostname_ssh,user_ssh,port_ssh,password_ssh)

        try:
            # Run a command on the remote server
            result = con_ssh.run("hostnamectl", hide=True)
            result1 = con_ssh.run("ls -la", hide=True)

            print(result.stdout)
            print(result1.stdout)

        except KeyboardInterrupt:
            print("Session interrupted by you!")

        except Exception:
                # Catch other exceptions without printing details
                pass

        finally:
            # Close the SSH connection
            con_ssh.close()

if __name__ == "__main__":
    main()

