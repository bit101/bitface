# bitface
Garmin Watch Face

![bitface](bitface.jpg)

This is a very simple watch face I made for my Garmin Forerunner 255. Made for my own education and because I wanted a highly visible watch face with time, date, steps and heart rate and not much else. The photo makes it seem to have a colored gradient background, but that's just a reflection. It's all black and white except for the red heart icon.

This will probably work on most Garmin watches, but sizes may need to be adjusted.

The current Garmin documentation pushes you towards using Visual Studio Code and the Monkey-C extension for Code. I was unable to get this working correctly on Manjaro Linux so I set up this project to use neovim and make.

## Build requirements:

### Garmin ConnectIQ

https://developer.garmin.com/connect-iq/overview/

This contains the language, Monkey-C, which is what Garmin faces and apps are written in, and the SDK, tool kit and simulator used to compile the face. Install as per instructions.

You'll also need to generate a developer key per the instructions. This should go in `build_res/developer_key`.

### FontBM

https://github.com/vladimirgamalyan/fontbm

Needed to create the bitmap font from a ttf. FontBM is a Linux tool which is compatible with BMFont, a Windows tool that is usually used for this purpose.

The font used is SquareFont by Bou Fonts, found on dafont.com:  https://www.dafont.com/squarefont.font . It is listed by the author and labeled as 100% free.

## General Info

Most of the important code is in `source/BitFaceView.mc`. It gets the time, date, heart rate and step count and draws it to the drawing context with some hard-coded layout properties.

The `Makefile` builds everything. If you change anything about the font you'll have to run `make font`. This clears any existing generated fonts and generates three different sized bitmap font files.

And if you do anything to the font or drawables, you need to clear the app cache. This was one of the toughest things to figure out. I kept changing things and the app didn't reflect the updates. Code changes are fine, but resource changes do not get updated until you clear the cache. There are make targets for all of this.

Make sure you run the simulator before building. The make file will run the newly built app in the simulator.

Fonts and other drawables are also defined in the `drawables` files. If you change anything, update those.

To make this run on other watch types, update the `manifest.xml` file. And change the target device in the make file too.
