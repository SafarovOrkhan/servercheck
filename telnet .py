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
        # Get password securelya
        password_ssh = getpass.getpass("Enter SSH password: ")
        print("You will enter one or more Telnet IP addresses and ports separated by "," ")
        telnetIpCheck = input("Telnet IP addresses: ")
        # Establish SSH connection
        con_ssh = establish_ssh_connection(hostname_ssh, user_ssh, port_ssh, password_ssh)
        telnetIpArray = telnetIpCheck.split(",")
        print(telnetIpArray)
        

        # Run sudo commands on the remote server
        please 
                #result = con_ssh.sudo("systemctl status "+i+" | head -n "+cutNumber, password=password_ssh , hide=True)
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