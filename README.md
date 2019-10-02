# ubuntu1604-nist800-171
The script in this repo will be used to apply NIST 800-171 controls to Ubuntu 16.04. This script has been applied to machines running Ubuntu Desktop 16.04 GNOME. At this time I have not developed anything for the Unity GUI to lock it down but may do so in the future.  

# Running This Script
In order to run this script you should be using an account that has full sudo access on the machine.
Just run sudo sh ub16-nist800171.sh

# Known Bugs
- AIDE installation is not automated
- krb5-user installation has not been automated correctly.
