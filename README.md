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

## Setup

Simply clone the repo and then copy the `.env.dist` file to `.env` and change the `REPOS_DIR` value. This will be the 
folder on your host where you have your repos or projects you are currently working on. You can add your AWS keys for the sysops container in this file too. 

Now... so long as you have docker installed and running, you can type the following:

```
./pillar build
```

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