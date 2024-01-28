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
        serviceCheck = input("Please enter service name : ")
        # Establish SSH connection
        con_ssh = establish_ssh_connection(hostname_ssh, user_ssh, port_ssh, password_ssh)
        

        # Run sudo commands on the remote server
        servicesArray = serviceCheck.split(",")
        print("selected services: "+str(servicesArray))
        for i in servicesArray:
            if (i == ""):
                continue
            else:
                isExist = con_ssh.sudo("systemctl list-units --type=service | grep  -w "+i+" | wc -l", password=password_ssh , hide=True).stdout.strip()
                if (int(isExist) == 0):
                    print("● Service: "+i+" is not found. Proceeding to next ...")
                    print("")
                    continue
                else:
                    cutNumber = con_ssh.sudo("systemctl status "+i+" | grep -n  \"CGroup: \" | cut -d : -f1", password=password_ssh , hide=True).stdout.strip()
                    result = con_ssh.sudo("systemctl status "+i+" | head -n "+cutNumber, password=password_ssh , hide=True)
                    print(result.stdout)

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