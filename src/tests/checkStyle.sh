#!/bin/bash

#Check for no spaces after commas
git grep "[0-9A-Za-z')],[0-9A-Za-z']"

#Check for no space btw =
##git grep "[0-9A-Za-z')]=[0-9A-Za-z']"

#Check for trailing spaces
git grep ' $'

