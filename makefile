.PHONY: setup

setup:
	rm -rf ~/.devel/personal
	mkdir -p ~/.devel/personal

publish:
	rm -rf ~/.devel/personal/kenichi-shibata.github.io
	mkdir -p ~/.devel/personal/
	hugo -d ~/.devel/personal/kenichi-shibata.github.io
	echo "kenichi.shibata.co.uk" > ~/.devel/personal/kenichi-shibata.github.io/CNAME
	echo "publish this via \`github.com/kenichi-shibata/kenichi-shibata\`\n" > ~/.devel/personal/kenichi-shibata.github.io/readme.md
	echo "\`make publish\`" >> ~/.devel/personal/kenichi-shibata.github.io/readme.md
	echo "https://themes.gohugo.io/hugo-theme-nix/ for more info" >> ~/.devel/personal/kenichi-shibata.github.io/readme.md
	git -C ~/.devel/personal/kenichi-shibata.github.io init
	git -C ~/.devel/personal/kenichi-shibata.github.io remote add origin git@github.com:kenichi-shibata/kenichi-shibata.github.io
	git -C ~/.devel/personal/kenichi-shibata.github.io add ~/.devel/personal/kenichi-shibata.github.io
	git -C ~/.devel/personal/kenichi-shibata.github.io commit -m "auto update from makefile"
	git -C ~/.devel/personal/kenichi-shibata.github.io push origin --force master

dev: # develop
	hugo server -D &
	open http://127.0.0.1:1313
