import optparse
from socket import *
import threading

def connScan(tgtHost, tgtPort):
    try:
        # TODO Create socket
        connSkt = socket(AF_INET, SOCK_STREAM)
        # creates socket using af_inet and sock_stream
        # TODO Connect to target host and port
        connSkt.connect((tgtHost, tgtPort))
        #connects to target host and post 
        print('[+]%d/tcp open'% tgtPort) 
        # TODO Send garbage data (any string you want)
        connSkt.send(b'this is a test\r\n')
        # sends thisisportscanner
        # TODO Get results from sending garbage string
        results = connSkt.recv(100)
        # revieve from garbage string
        print('[+] ' + str(results))
        # TODO close the socket
    except:
        print('[-]%d/tcp closed'% tgtPort)
    finally: 
        connSkt.close()
        # closes the socket after running this block of code

def portScan(tgtHost, tgtPorts):
    try:
        tgtIP = gethostbyname(tgtHost)
    except:
        print("[-] Cannot resolve '%s': Unknown host" %tgtHost)
        return
    try:
        tgtName = gethostbyaddr(tgtIP)
        print('\n[+] Scan Results for: ' + tgtName[0])
    except:
        print('\n[+] Scan Results for: ' + tgtIP)
    setdefaulttimeout(1)
    for tgtPort in tgtPorts:
        print('Scanning port ' + tgtPort)
        # TODO thread the scan so that you run connScan for each target on a separate thread.
        t = threading.Thread(target=connScan, args=(tgtHost, int(tgtPort)))
        t.start()

def main():
    parser = optparse.OptionParser("usage%prog "+ "-H <target host> -p <target port>")
    parser.add_option('-H', dest='tgtHost', type='string', help='specify target host')
    parser.add_option('-p', dest='tgtPort', type='string', help='specify target port[s] separated by comma')
    (options, args) = parser.parse_args()
    tgtHost = options.tgtHost
    if '-' in options.tgtPort:
        start_port, end_port = options.tgtPort.split('-')
        tgtPorts = [str(port) for port in range(int(start_port), int(end_port) + 1)]
    else:
        tgtPorts = [options.tgtPort]

    if (tgtHost is None) or (tgtPorts[0] is None):
        print('[-] You must specify a target host and port[s].')
        exit(0)
    portScan(tgtHost, tgtPorts)

if __name__ == '__main__':
    main()
