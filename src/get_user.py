# to get username in run.sh
# without this, username is root because of sudo

# importing os module
import os

# using getlogin() returning username
print(os.getlogin())
