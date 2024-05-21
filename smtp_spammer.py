import smtplib
import optparse
from email.mime.text import MIMEText

def sendMail(user,pwd,to,subject,text):
    # TODO Create a MIMEText message
    msg = MIMEText(text, 'plain')
    msg['Subject'] = subject
    #designate the Subject line of email
    msg['From'] = user
    #designates the from section
    msg['To'] = to
    #designates the to section
    email_content = msg.as_string()
    print(email_content)

    try:
    
        print( "[+] Connecting To Mail Server.")
        #TODO Connect to Mail Server
        server = smtplib.SMTP('smtp.gmail.com', 587)
        server.ehlo()
        #connects to the server and calls the smtplib.smtp function into being
        
        print("[+] Starting Encrypted Session.")
        #TODO Start encrypted session
        server.starttls()
        #configures to sent via TLS instead of SSL
        
        print("[+] Logging Into Mail Server.")
        #TODO Log into mail server
        server.login(user, pwd)
        #calls to the arguments entered for user and password
        
        print("[+] Sending Mail.")
        #TODO Send mail
        server.sendmail(user, to, msg.as_string())
        #calls user, to, and the message to send to the recipient
        print("[+] Mail Sent Successfully.")
    except Exception as e:
         print(f"[-] Sending Mail Failed. Reason: {e}")
         #updated this to exception to catch the breaks. 

def main():
    parser = optparse.OptionParser('usage%prog '+\
      '-t <target email> '+\
      '-l <gmail login> -p <gmail password>')
    parser.add_option('-t', dest='tgt', type='string',\
      help='specify target email')
    parser.add_option('-l', dest='user', type='string',\
      help='specify gmail login')
    parser.add_option('-p', dest='pwd', type='string',\
      help='specify gmail password') 
    (options, args) = parser.parse_args()
    tgt = options.tgt
    user = options.user
    pwd = options.pwd
    if tgt == None or user ==None or pwd==None:
        print (parser.usage)
        exit(0)
    spamMsg = "PLACEHOLDER"
    subject = "PLACEHOLDE"
    sendMail(user, pwd, tgt, subject, spamMsg)

if __name__ == '__main__':
    main()
