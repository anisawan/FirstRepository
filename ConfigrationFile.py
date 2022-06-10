from configparser import ConfigParser
import json


class ConfigrationFile():
    
    """ config file format will be
    ***Config File Example***
    [DATA]
    remail= rmail@yahoo.com
    Password=mypassword
    semail=mymail@gmail.com
    imap=imap.gmail.com
    port=993
    path=path/to/directory
    list=["123","356","4","5654"]
    
    and save file as file.ini
    
    ***Robot file example***
    *** Settings ***
    Library     Autosphere.ConfigrationFile

    ***Task***
    Test key Word
        ${passw}=  Get Value From Config File  chk.ini  DATA  Password
        ${my_list}=   Get Value From Config File    chk.ini  DATA  remail
        ${passw}=  Get Value From Config File  chk.ini  DATA  path
        ${passw}=  Get Value From Config File  chk.ini  DATA  port
        ${passw}=  Get Value From Config File  chk.ini  DATA  imap
        ${passw}=  Get Value From Config File  chk.ini  DATA  semail
        ${my_list}=  Get List From Config File  chk.ini  DATA  list
    """
    
    def  get_value_from_config_file(self,file,data,name): 
        
        """This function will take 3 values.
        :param File: path and name of file.
        :param Data: name of data frame inside config file
        :param Name: name of value which you want to return form config file.
        Return: value"""
        parser = ConfigParser()
        parser.read(file)
        val = parser.get(data, name)
        return         val   
    
    
    
    def  get_list_from_config_file(self,file,data,name): 
        """This function will take 3 values.
        :param File: path and name of file.
        :param Data: name of data frame inside config file
        :param Name: name of list which you want to return form config file.
        Return: List"""
        parser = ConfigParser()
        parser.read(file)
        val_list = json.loads(parser.get(data, name))
        return         val_list  
