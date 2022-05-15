# Pillar

A simple and easy to use PHP development stack targeted towards development of microservices with apache kafka

> Direct Windows support has been removed due to ongoing issues with file permissions in mounted volumes. Windows will still work however you will need to use within WSL2 instead

## Whats included

- PHP 8.0
- PHP 7.4
- PHP 7.0 (For legacy applications)
- Node
- Mysql
- Dnsmasq (for automatic DNS)
- Mailhog
- Kafka
- Zookeeper
- AKHQ
- Sysops container (AWS tools, Digital Ocean CLI, NVM, Node & Serverless CLI, Terraform)
- Minio (For faking AWS S3)
- DynamoDB
- Privoxy

## Setup

Simply clone the repo and then copy the `.env.dist` file to `.env` and change the `REPOS_DIR` value. This will be the 
folder on your host where you have your repos or projects you are currently working on. You can add your AWS keys for the sysops container in this file too. 

Now... so long as you have docker installed and running, you can type the following:

```
./pillar build
```

> WARNING: sudo usage... Do not run this command with sudo as docker commands would then run under the wrong user and all hell will break loose. You will still be asked for your password as in the pillar commands sudo is used to set the dns automatically of your connection to use pillar saving you have to do it yourself.

Once built you can use the stack via the commands in your script of choice. 

You can also download my windows TrayController here which has built in support for controlling Pillar direct from your windows tray - https://github.com/tristanbettany/TrayController

> Note: this most likley needs to be updated due to the recent removal of direct windows support

## URLs & DNS

Because of the automatic DNS you dont need to mess with hosts files, just set your DNS in your network settings to 
`127.0.0.1` and everything will resolve automatically. For instance you should be able to access a project at `myproject.80.test`
where the `80` is the version of php you want.

## SSL

A quick note about SSL. After building a `pillar-ca.pem` file will be generated in `resources/ca`. You want to import that 
file into your browser SSL certificates under `Trusted Root Certification Authorities`. This means you wont then get any warnings
about SSL in the browser.

## DynamoDB

There's a container to use dynamodb locally and a small shell script to make some regular commands for interacting with it a little simpler. For example when in the sysops container you can use this command to create a dynamodb table on the dynamodb container with just an id

```
ddb create-table test AttributeName=id,AttributeType=S AttributeName=id,KeyType=HASH
```

## Privoxy & Remote Working Privacy

> Pre-note: I am not opposed to companies using traffic sniffing VPNs for "security" at all, but often the security, privacy and efficiency of the developers workflow is not taken into account when implimenting company wide processes such as VPNs. The following helps developers to deal with such scenarios.

Privoxy has been installed to help with the workflow and privacy of any remote developer in a company which requires them to connect to traffic sniffing VPNs. This can comprimise the safety and privacy of the employee and negativley affect efficiency by requiring them to switch between multiple devices when working to save comprimising personal logins. 

A perfect example of developers using personal accounts for work is due to the fact that developers are generally rather unique, in that they tend to have large amounts of personal code which can be quickly re-used or referenced on personal version control accounts. All developers generally do this to assist in efficincy and improve their quality and quantity of output at work. (I dont think this is really a closley guarded secret in the community right?)

*So.... whats the easiest way both parties can have what they want here?...*

A Privoxy Container is included in this stack exposed on port 8118. you can run this stack on the machine you need to VPN your traffic through and then on your "kiosk" development machine use firefox to proxy your traffic through it. All your other applications other than firefox will go directly to the normal internet and firefox will go through privoxy and then off to the VPN. *Win Win*

You can also SSH from your "kisok" machine to the machine with this stack installed on to use the CLI and do anything else atall.

You can also install something like the PHPStorm backend on the machine this stack is installed on and then use the PHPStorm client from your "kisok" machine to assure that all your code stays on the right machine and the security of the companies code is safe while you also maintain your privacy.