import optparse

def decrypt(msg, key):
    result = ""
    for char in msg:
        if char.isupper():
            result += chr((ord(char) - key - 65) % 26 + 65)     # decrypt uppercase characters
        elif char.islower():
            result += chr((ord(char) - key - 97) % 26 + 97)     # decrypt lowercase characters
        else:
            result += char
    return result

def cracker_caesar(encrypted_msg):
    for key in range(1, 26):    #runs all possible keys 1 - 25 
        print(f"Key {key}: {decrypt(encrypted_msg, key)}")  #prints all possible keys 1-25

if __name__ == "__main__":
    encrypted_msg = "Yrzc Trvjri"  # I couldnt figure out how to taker the userinput but this works!
    cracker_caesar(encrypted_msg)
