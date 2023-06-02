build: 
	monkeyc -d fr255 -f monkey.jungle -o bitface.prg -y build_res/developer_key
	monkeydo bitface.prg fr255

build_full: font build

font: clean
	build_res/fontbm --font-size 114 --chars 48-58 --background-color 0,0,0 --spacing-vert 1 --spacing-horiz 1 --font-file build_res/square.ttf --output resources/fonts/time
	build_res/fontbm --font-size 32 --chars 45,48-57 --background-color 0,0,0 --spacing-vert 1 --spacing-horiz 1 --font-file build_res/square.ttf --output resources/fonts/data
	build_res/fontbm --font-size 20 --background-color 0,0,0 --spacing-vert 1 --spacing-horiz 1 --font-file build_res/square.ttf --output resources/fonts/date

clean: clean_cache
	rm -f resources/fonts/*.fnt
	rm -f resources/fonts/*.png

clean_cache:
	rm -rf gen/*
	rm -f bitface.prg
	rm -f bitface.prg.debug.xml
