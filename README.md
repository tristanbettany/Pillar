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
- Node
- Kafka
- Zookeeper
- AKHQ

## Setup

Simply clone the repo and then so long as you have docker installed and running, you can type in powershell:

```
./pillar.ps1 build
```

You may get a warning about enabling script execution which is fine, if your concerned about that then read the code first
or just execute docker commands directly.

Once built you can use the stack via the commands in the PS1 script or you can download my TrayController here
which has built in support for controlling Pillar direct from your tray - https://github.com/tristanbettany/TrayController


