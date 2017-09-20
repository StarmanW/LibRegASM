'''
	This is a mock-up of CSA
    	Date: 14 July 2017
	Version: 20-SEP-2017
'''

# import sys and time - sys for flush, time for delay
import sys, time, re

lib_name = ["ZionX", "StarmanW", "Zanox"]
lib_ID = ["16SMD00990", "16SMD05879", "16SMD45789"]
date_joined = ["11/12/2017", "01/1/2013", "12/05/2014"]

# Login function
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
    return True if login_success else False

# Main menu function
def main_menu():
    print("\n" + ("=" * 12) + " Main Menu " + ("=" * 12))
    print("1. Show librarian list")
    print("2. Add new librarian")
    print("3. Delete a librarian records")
    print("4. Exit program")
    print("=" * 35)
    choice = input("Enter choice: ")

    while (len(choice) > 1 or choice[0] != "1" and choice[0] != "2" and choice[0] != "3" and choice[0] != "4"):
        print("Invalid input, please try again with the range 1 to 3 only.\n")
        choice = input("Enter choice: ")
    return choice

def display_librarian():
    print("\n================ Librarians ================")
    print("Librarian Name \t Librarian ID \t Date Joined")
    print("-------------- \t ------------ \t -----------")
    for name, ID, date_join in zip(lib_name, lib_ID, date_joined):
        print("%-12s \t %-10s \t %-10s" % (name, ID, date_join))
    print("-------------- \t ------------ \t -----------")

def add_librarian():
    count = 0
    addMore = "Y"

    while (addMore.upper() == "Y"):
        name = input("\nEnter librarian name: ")

        id = input("Enter librarian ID (e.g. 16AAA12345): ")
        while not re.match("^\d{2}[A-Z]{3}\d{5}$", id):
            print("Invalid ID format, please try again with the correct format.\n")
            id = input("Enter librarian ID (e.g. 16AAA12345): ")

        lib_date_joined = input("Enter date joined (dd/MMM/yyyy): ")
        while not re.match("^(([0-2][0-9])|([3][0-1]))\-(JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)\-\d{4}$", lib_date_joined):
            print("Invalid date format, please try again with the correct format.\n")
            lib_date_joined = input("Enter date joined (dd/MMM/yyyy): ")

        # Add new librarians details into list
        lib_name.append(name)
        lib_ID.append(id)
        date_joined.append(lib_date_joined)

        count += 1
        addMore = input("Do you wish to add more librarians? (Y/N): ")

        while (addMore.upper() != "Y" and addMore.upper() != "N"):
            print("Invalid input, please try again with \"Y\" or \"N\" only.\n")
            addMore = input("Do you wish to continue? (Y/N): ")

    print("\n%d of librarian added into the system\n" % count)

def delete_librarian():
    prompt_del = input("Enter librarian ID to delete record: ")  # Get librarian name to delete

    # Re-prompt user if librarian is not found
    while prompt_del not in lib_ID:
        print("Librarian not found in database, please try again.\n")
        prompt_del = input("Enter librarian ID to delete record: ")

    # Get index and delete all the records according to the index
    index = lib_ID.index(prompt_del)
    del lib_name[index]
    del lib_ID[index]
    del date_joined[index]

    print("Librarian records successfully deleted.")

def terminate_prog():
    print("System is now exiting...")
    time.sleep(1)
    sys.exit(0)

'''----------------------------------------'''
'''--------- Program Main Section ---------'''
'''----------------------------------------'''
# Get boolean return statement from loginFunction()
loginPass = login_function()

# If login success and returned True
if(loginPass):
    cont = "Y"  # Initialize cont as prompt for continue

    # While user wants to continue the program, keep looping
    while (cont.upper() == "Y"):
        choice = main_menu() # Get the user choice
        if (choice == "1"):
            display_librarian()
        elif (choice == "2"):
            add_librarian()
        elif (choice == "3"):
            delete_librarian()
        elif (choice == "4"):
            terminate_prog()
        cont = input("Do you wish to continue? (Y/N): ")
        while (cont.upper() != "Y" and cont.upper() != "N"):
            print("Invalid input, please try again with \"Y\" or \"N\" only.\n")
            cont = input("Do you wish to continue? (Y/N): ")

    terminate_prog()    # Terminate the program
