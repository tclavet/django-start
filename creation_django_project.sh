#!/bin/bash

RED="\033[1;31m"
GREEN="\033[1;32m"
NOCOLOR="\033[0m"

creation()
{
	virtualenv venv
	source venv/bin/activate
	pip install django
	django-admin startproject $1
	cd $1
	python manage.py startapp $2
	python manage.py migrate
}

if [ "$#" != 2 ]
then
	echo -e "${RED}Please enter two variables for project and app${NOCOLOR}";
	return
fi

echo -e "${GREEN}Do you wish to install this project (y/n)?${NOCOLOR}"
read  yn
case $yn in
     [Yy]* ) creation $1 $2;;
     [Nn]* ) return;;
     * ) echo -e "${RED}}Please answer yes or no.${NOCOLOR}";;
esac

echo -e "${GREEN}Do you want to set up a superuser (y/n)?${NOCOLOR}"
read  yn
case $yn in
	[Yy]* ) python manage.py createsuperuser;;
	[Nn]* ) ;;
	* ) echo -e "${RED}Please answer yes or no.${NOCOLOR}";;
esac

echo -e "${GREEN}Project $1 and app $2 successfully created with django"
echo "Please think about installing necessary packages.${NOCOLOR}"
