'''
    This is a mock-up
    Date: 14 July 2017
'''

#import sys and time - sys for flush, time for delay
import sys
import time

#Login function
def login_function():

    login_success = False

    print('=' * 20)
    print('       LOGIN')
    print('=' * 20)

    while not login_success:
        login_id = input('Login ID: ')
        password = input('Password: ')

        if login_id != 'admin' or password != '12345':
            print('Invalid login ID or password, please try again.\n')
            login_success = False
        else:
            login_success = True

    if login_success:
        return True
    else:
        return False

#Main menu function
def mainMenu():
    print("\n===== Main Menu =====")
    print("1. Show librarian list")
    print("2. Add new librarian")
    print("3. Delete a librarian records")
    print("4. Exit program")
    choice = input("Enter choice: ")
    sys.stdin.flush()

    while (len(choice) > 1 or choice[0] != "1" and choice[0] != "2" and choice[0] != "3" and choice[0] != "4"):
        print("Invalid input, please try again with the range 1 to 3 only.\n")
        choice = input("Enter choice: ")
        sys.stdin.flush()
    return choice

'''----------------------------------------'''
'''--------- Program Main Section ---------'''
'''----------------------------------------'''
#Get boolean return statement from loginFunction()
loginPass = login_function()

#If login success and returned True
if (loginPass):
    cont = "Y"  #Initialize cont as prompt for continue

    librarianName = ["Samuel", "StarmanW", "Zanox"]
    librarianID = ["16SMD00990", "16SMD05879", "16SMD45789"]
    librarianDateJoined = ["11/12/2017", "01/1/2013", "12/05/2014"]

    #While user wants to continue the program, keep looping
    while (cont.upper() == "Y"):
        choice = mainMenu() #Get the user choice
        if (choice == "1"):
            print("\n================ Librarians ================")
            print("Librarian Name \t Librarian ID \t Date Joined")
            print("-------------- \t ------------ \t -----------")
            for name, ID, dateJoined in zip(librarianName, librarianID, librarianDateJoined):
                print("%-12s \t %-10s \t %-10s" % (name, ID, dateJoined))
            print("-------------- \t ------------ \t -----------")
        elif (choice == "2"):
            count = 0
            addMore = "Y"

            while (addMore.upper() == "Y"):
                libname = input("\nEnter librarian name: ")
                sys.stdin.flush()
                libID = input("Enter librarian ID : ")
                sys.stdin.flush()
                libDateJoined = input("Enter date joined (dd/mm/yyyy): ")
                sys.stdin.flush()

                #Add new librarians details into list
                librarianName.append(libname)
                librarianID.append(libID)
                librarianDateJoined.append(libDateJoined)

                count+=1
                addMore = input("Do you wish to add more librarians? (Y/N): ")

                while (addMore.upper() != "Y" and addMore.upper() != "N"):
                    print("Invalid input, please try again with \"Y\" or \"N\" only.\n")
                    addMore = input("Do you wish to continue? (Y/N): ")
                    sys.stdin.flush()

            print("\n{} of librarian added into the system\n".format(count))
        elif (choice == "3"):
            promptDelete = input("Enter librarian name to delete records: ")    #Get librarian name to delete

            #Reprompt user if librarian is not found
            while (promptDelete not in librarianName):
                print("Librarian not found in database, please try again.\n")
                promptDelete = input("Enter librarian name to delete records: ")

            #Get index and delete all the records according to the index
            libIndex = librarianName.index(promptDelete)
            del librarianName[libIndex]
            del librarianID[libIndex]
            del librarianDateJoined[libIndex]

            print("Librarian records successfully deleted.")
        elif (choice == "4"):
            print("System is now exiting...")
            time.sleep(1)
            sys.exit(0)

        cont = input("Do you wish to continue? (Y/N): ")
        sys.stdin.flush()

        while (cont.upper() != "Y" and cont.upper() != "N"):
            print("Invalid input, please try again with \"Y\" or \"N\" only.\n")
            cont = input("Do you wish to continue? (Y/N): ")
            sys.stdin.flush()

    print("System is now exiting...")
    time.sleep(1)
    sys.exit(0)
