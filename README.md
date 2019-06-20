# pubc
=======

pubg the way it's supposed to be (with MFI controller support)

Building: (requires Xcode)

1. check out the project recursively
2. make stage (or make package if you have dpkg installed)

How it works:

1. I map the x,y coordinates of each of the buttons on this screenshot I took on my 6s

![alt text](game_play_map.jpg "Mapping Screen"

2. Hook IOSAppDelegate and our PUBGController class

3. This class listens for game controllers and upon receiving one, sets it up to receive value change handlers

4. Map buttons to different CGPoints that touches are simulated for on the screen.

Custom button mapping:

pubg/layout/private/var/mobile/Library/Preferences/com.nito.pubc.plist.og

(it is named as .og because postinst moves it to com.nito.pubc.plist if it doesn't already exist)

PUBGDefines.h has all the constants available that can be changed in that plist file to their corresponding buttons. You can change the values in the plist before you build and install it, OR you can change those values on device directly at /private/var/mobile/Library/Preferences/com.nito.pubc.plist

Wiki Page: https://wiki.awkwardtv.org/wiki/Pubc




