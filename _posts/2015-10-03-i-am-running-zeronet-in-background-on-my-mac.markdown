---
author: koalalorenzo
comments: true
date: 2015-10-03 11:30:08+00:00
excerpt: Short and simple guide to show how I was able to set up a launchd daemon
  on OS X to run a ZeroNet Node in background.
layout: post
slug: i-am-running-zeronet-in-background-on-my-mac
title: I am running ZeroNet in background on my Mac
wordpress_id: 18650
categories:
- How To
- Decentralized
tags:
- apple
- bitcoin
- mac
- osx
- p2p
- python
- zeronet
- bittorrent
- tor

---

Since when I was little, I always loved peer-to-peer technologies... I even tried to create a GNU/Linux distribution based on that. .. but recently I have discovered a brilliant project that is combining the power of **asynchronous cryptography**, using **Bitcoin** private and public keys, with **BitTorrent technology.** This project is called [ZeroNet](http://zeronet.io) and it is a new and interesting way to provide websites and real-time services in a p2p network.

{%
  include image.html
  img="images/2015/zeronet.png"
%}

To join the network and browse the ZeroNet websites, now you have to **keep running a python software** in one of your **terminal**. I really hate to keep it opened 24h a day... even if I am nerd enough to love logs. I decided to run an instance of ZeroNet in background on my Mac: every time I turn on my computer, I am updating and seeding content. I feel happy to help this community 👍 Here is how I made it possible. <!--more-->

First, I have created a _launchd daemon_. So I cloned the [github project repository](https://github.com/HelloZeroNet/ZeroNet) in my home directory (~/ZeroNet).

    $ cd ~ ; git clone https://github.com/HelloZeroNet/ZeroNet.git

Then after that I have created the launchd daemon by editing the file:

    $ nano ~/Library/LaunchAgents/io.zeronet.plist

And adding the following content, of course **replacing** /Users/koalalorenzo with **your own home path**:

    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
     <dict>
       <key>Label</key>
       <string>io.zeronet</string>
       <key>ProgramArguments</key>
       <array>
         <string>/Users/koalalorenzo/ZeroNet/start.sh</string>
       </array>
       <key>EnvironmentVariables</key>
       <dict>
         <key>HOME</key>
         <string>/Users/koalalorenzo/ZeroNet</string>
         <key>STNORESTART</key>
         <string>1</string>
       </dict>
       <key>KeepAlive</key>
       <true/>
     </dict>
    </plist>

I have then added a new script able to update the repository and run the server. So I have edited a second file:

    $ nano ~/ZeroNet/start.sh

Adding in it the following simple code:

    #!/bin/bash
    cd /Users/koalalorenzo/ZeroNet/
    git pull
    sleep 5
    /usr/bin/python /Users/koalalorenzo/ZeroNet/zeronet.py

Then I had to change the permissions of the file so the Daemon would run it:

    $ chmod +x ~/ZeroNet/start.sh

The only thing missing was to launch it! So I had to activate the Daemon on launchd by running the following commands:

    $ launchctl load ~/Library/LaunchAgents/io.zeronet.plist

Once loaded, because I had every dependencies installed and it was running already before, the daemon works without errors, allowing me to browse to ZeroNet, without having a terminal opened. :)
