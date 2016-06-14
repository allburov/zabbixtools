#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: Aleksey Burov, DevOpsHG

# This module common in ZabbixTools

import argparse
import sys
import os
import tempfile
import datetime


ZABBIX_SERVER = "https://server.name.com"

Debug = False

parser = argparse.ArgumentParser()
parser.add_argument("-v", "--verbose", action="store_true",
                    help="increase output verbosity")


def DebugMsg(msg):
    if Debug:
        print(msg)


def PrintArgs():
    DebugMsg('Script started with next variables: {}'.format(sys.argv[1:]))


def PwdTemp():
    tempdir = tempfile.gettempdir()
    DebugMsg("Temp dir is: {}".format(tempdir))
    os.chdir(tempdir)
    DebugMsg("PWD: {}".format(os.getcwd()))

def MainDecorator(func):

    def wrapped(*args, **kwargs):

        PrintArgs()
        PwdTemp()
        DebugMsg("Start at {}".format(datetime.datetime.today()))

        result = func(*args, **kwargs)

        DebugMsg("End at {}".format(datetime.datetime.today()))

        return result

    return wrapped
