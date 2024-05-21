import optparse
from pexpect import pxssh

botNet = []

class Client:
    def __init__(self, host, user, password):
        self.host = host
        self.user = user
        self.password = password
        self.session = self.connect()
    def connect(self):
        try:
            # TODO create an SSH connection with pxssh
            s = pxssh.pxssh()
            s.login(self.host, self.user, self.password)
            return s
        except pxssh.ExceptionPxssh as e:
            print(f"[-] Error Connecting to {self.host}: {e}")
            return None 
    def send_command(self, cmd):
        # TODO issue a command to the remote server
        if self.session:
             self.session.sendline(cmd)
             self.session.prompt()
             return self.session.before
        return ''
    def alive(self):
         if self.session:
              return not self.session.eof()
         return False

def addClient(host, user, password):
         client = Client(host, user, password)
         botNet.append(client)

         

def botnetCommand(command):
            # TODO issue a command to each client in the botnet
            global botNet
            for client in botNet:
                if client.alive():
                    output = client.send_command(command)
                    print('[*] Output from {client.host}')
                    print('[+] {output} \n')
                else:
                 print(f'[-] {client.host} is not responding')


def main():
    addClient('#ipaddress', '#user', '#pass')
    addClient('#ipaddress', '#user', '#pass')
    
    parser = optparse.OptionParser('usage %prog -H <target host> -u <user> -p <password>')
    parser.add_option('-H', dest='tgtHost', type='string', help='specify target host')
    parser.add_option('-u', dest='user', type='string', help='specify the user')
    parser.add_option('-p', dest='passwd', type='string', help='specify the password')
    (options, args) = parser.parse_args()
    if options.tgtHost is None or options.user is None or options.passwd is None:
        print(parser.usage)
        exit (0)
    else:
        addClient(options.tgtHost, options.user, options.passwd)

    botnetCommand('uname -v')
    
    botnetCommand('cat /etc/issue')

if __name__ == '__main__':
     main()

