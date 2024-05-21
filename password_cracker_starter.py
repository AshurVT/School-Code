import crypt
import sys


def testPass(cryptPass, dictfile):

    with open(dictfile, 'r') as f:
        for word in f.readlines():
            word = word.strip()  # Remove newline character
            
            # Extract the salt from the hashed password
            salt = cryptPass[:2].strip()
            #for debugging purposes remove the '#' from the following line
            # print("Extracted salt:", salt)
            
            # Encrypt the word with the salt
            cryptWord = crypt.crypt(word, salt)
            # for debugging purposes remove the '#' from the following line
            # print("Attempting to hash word:", word, "with salt:", salt, "Result:", cryptWord)
            
            # Compare the hashed word with the hashed password
            if cryptWord == cryptPass:
                print("[+] Found Password:", word)
                return word  # Return the plaintext password
    
    print("[-] Password Not Found.")
    return None  # Return None if password is not found         

    # TODO use the dictionary and crypt to identify possible plaintext passwords that match cryptPass

    # If the password is found, use the following:
        #print("[+] Found Password: "+plaintext_password+"\n")
        #return
    # Else:
        #print("[-] Password Not Found.\n")
        #return
    # raise NotImplementedError

def main(passwdfile,dictfile):
        with open(passwdfile, 'r') as f: #opens the password file and reading each line
            for line in f.readlines():
                line = line.strip()
                if ':' in line:
                    user, cryptPass = line.split(':')
                    cryptPass = cryptPass.strip() 
                print("[*] Cracking Password For: "+ user) #cracks the password for user

    # TODO take in a password file and a dictionary file and attempt to crack each password in the password file using testPass()
                plaintext_password = testPass(cryptPass, dictfile)

                if plaintext_password:
                    print("[+] Found password for", user + ":", plaintext_password)
                else:
                    print("[-] Password Not Found for", user)

if __name__ == "__main__":
    passwdfile=sys.argv[1]
    dictfile=sys.argv[2]
    main(passwdfile,dictfile)
