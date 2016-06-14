# zabbixtools
Tools for Zabbix routines

### Naming convention
* Zabbix*.py - Common scripts - generator, parsing.
* ZabbixAlert*.py - script for alerting (alertscripts)
* ZabbixServer*.py - server-side Zabbix item (externalscripts)
* ZabbixAgent*.py - script for zabbix-agent side (UserParameters)
* ZabbixAPI*.py - for work with Zabbix API

### Names of Folders and Files in repo
* profiles - templates for Zabbix
* config - for config item and trigger in zabbix-agent

### Usage:

#### Requirements:
* Installed Python 3.4 on Zabbix-server and Zabbix-agent
* On zabbix-agent pip modules: requirements-agent.txt
* On zabbix-server pip modules: requirements-server.txt

#### Zabbix-server
* Change *ZABBIX_SERVER* in *ZabbixCommon.py* to your zabbix-server address
* Copy to **/usr/lib/zabbix/zabbixtools**
* Change path in **/etc/zabbix/zabbix_server.conf**:
  * *ExternalScripts=/usr/lib/zabbix/zabbixtools*
  * *AlertScriptsPath=/usr/lib/zabbix/zabbixtools*

#### Windows-agent
* Copy this directory to **C:\ZBX\zabbixtools**
* Add **Include=C:\ZBX\zabbixtools\zabbix_agentdWIN.conf** to zabbix configuration file
* Restart Zabbix-Agent service

#### Linux-agent
* Copy this directory to **/srv/ZBX/zabbixtools**
* Add **Include=/srv/ZBX/zabbixtools/zabbix_agentdNIX.conf** to zabbix configuration file
* Restart Zabbix-Agent service