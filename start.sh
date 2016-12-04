#!/bin/bash

sudo sane-find-scanner
sudo scanimage -L

# need to do this on start for some reason
sudo service apache2 restart

# Start 
/bin/bash
