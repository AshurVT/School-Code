from pexpect import pxssh

def connect_and_execute(host, user, password, command):
    try:
        # Establish an SSH session
        session = pxssh.pxssh()
        session.login(host, user, password)
        
        print(f"[+] SSH connection established with {host}")
        
        # Execute the specified command
        session.sendline(command)
        session.prompt()  # Wait for the command to complete
        
        # Print command output
        print(session.before.decode().strip())
        
        # Logout from the session
        session.logout()
        print("[+] SSH session terminated.")
        
    except pxssh.ExceptionPxssh as e:
        print(f"[-] Error connecting: {e}")
        
if __name__ == "__main__":
    host = "127.0.0.1"
    user = "kali"  # kali username
    password = "kali"  # kali password
    command = "sudo cat /etc/shadow | grep root"
    
    # Attempt to connect and execute the command
    connect_and_execute(host, user, password, command)
