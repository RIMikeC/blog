---
name: New windows server
about: Request for someone to build a new server
title: ''
labels: ''
assignees: ''

---

**Mandatory fields**

**Environment**
One of dev, staging or prod

***Product***
Name of the product, alphanumerical only

***AMI Version***
For example "Base-2020.01.15" or "SQL_2019_Standard-2019.12.16"

***Owner***
Name of the person who understands this server best

***Instance Type***
Please don't use t3 for production! Nothing smaller than t3.medium even in dev

***Customisation Script***
Normally the name of Powershell script that installs the application. This can be emailed to the person who picks up the issue

***Additional Ports***
Any application or database-specific ports that need to be opened. Record whether the traffic is inbound (towards the server) or outbound (from the server) and whether it is for TCP, UDP or both.

***Additional Volumes***
List the sizes in GB (other than C). These will be mounted as D, E and F. 





**Additional context**
Any additional information that is relevant
