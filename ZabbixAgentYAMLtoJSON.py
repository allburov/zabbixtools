#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Author: Aleksey Burov, DevOpsHG

# This script get convert YAML to JSON and send to Zabbix. 

import yaml
import json

from ZabbixCommon import parser, DebugMsg
import ZabbixCommon

@PtZabbixCommon.MainDecorator
def Main(pathToFile):

    with open(pathToFile, 'r') as f:
        yamlData = yaml.load(f)

    data = yamlData['data']
    yamlDataNew = {'data': []}
    dataNew = yamlDataNew['data']

    # Перебираем каждый элемент
    for item in data:
        dict = {}

        # Изменяем каждый ключ с KEYNAME на {#KEYNAME} (требует Zabbix)
        for key in item:
            newkey = "{{#{}}}".format(key.upper())
            dict[newkey] = item[key]

        dataNew.append(dict)

    jsonData = json.dumps(yamlDataNew)
    DebugMsg("JSON data is:")
    print(jsonData)


if __name__ == "__main__":

    parser.add_argument("-f", "--PathToFile", help="Path to yaml file", required=True)

    args = parser.parse_args()
    PtZabbixCommon.Debug = args.verbose

    Main(
        args.PathToFile
    )
