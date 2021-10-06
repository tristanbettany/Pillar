# Pillar

A simple and easy to use PHP development stack targeted towards development of microservices with apache kafka

This project is designed for windows users so the following instructions are written assuming you are using windows.

## Whats included

- PHP 8
- PHP 7.4
- Node
- Mysql
- Dnsmasq (for automatic DNS)
- Mailhog
- Kafka
- Zookeeper
- AKHQ
- Sysops container (AWS tools, NVM, Node & Serverless CLI)

## Setup

Simply clone the repo and then copy the `.env.dist` file to `.env` and change the `REPOS_DIR` value. This will be the 
folder on your host where you have your repos or projects you are currently working on.

Now... so long as you have docker installed and running, you can type in powershell:

```
./pillar.ps1 build
```

You may get a warning about enabling script execution which is fine, if your concerned about that then read the code first
or just execute docker commands directly.

Once built you can use the stack via the commands in the PS1 script or you can download my TrayController here
which has built in support for controlling Pillar direct from your tray - https://github.com/tristanbettany/TrayController

## URLs & DNS

Because of the automatic DNS you dont need to mess with hosts files, just set your DNS in your network settings to 
`127.0.0.1` and everything will resolve automatically. For instance you should be able to access a project at `myproject.80.test`
where the `80` is the version of php you want.

## SSL

A quick note about SSL. After building a `pillar.crt` file will be generated in `resources/ca`. You want to import that 
file into your browser SSL certificates under `Trusted Root Certification Authorities`. This means you wont then get any warnings
about SSL in the browser.
