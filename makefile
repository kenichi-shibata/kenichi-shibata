.PHONY: setup

setup:
	rm -rf ~/.devel/personal
	mkdir -p ~/.devel/personal
	git clone git@github.com:kenichi-shibata/kenichi-shibata ~/.devel/personal/kenichi-shibata
	git clone git@github.com:kenichi-shibata/kenichi-shibata.github.io ~/.devel/personal/kenichi-shibata.github.io

publish:
	hugo -D ~/.devel/personal/kenichi-shibata.github.com
	echo "kenichi.shibata.co.uk" > ~/.devel/personal/kenichi-shibata.github.io
	git -C ~/.devel/personal/kenichi-shibata.github.io add ~/.devel/personal/kenichi-shibata.github.io
	git -C ~/.devel/personal/kenichi-shibata.github.io commit -m "auto update from makefile"
	git -C ~/.devel/personal/kenichi-shibata.github.io push origin --force master
