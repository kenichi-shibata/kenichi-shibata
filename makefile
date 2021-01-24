.PHONY: setup

setup:
	rm -rf ~/.devel/personal
	mkdir -p ~/.devel/personal

build:
	echo "building in the same dir check public/"
	hugo
	echo "now you can open this dir using chrome browser"
	echo "open `pwd`/public/index.html"
	open `pwd`/public/index.html

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
	hugo server -D -p 1313 &
	open http://127.0.0.1:1313

kill:
	pkill hugo

purge: # ref: https://api.cloudflare.com/#zone-purge-all-files, create token https://servebolt.com/help/article/how-to-set-up-automatic-cloudflare-cache-purging-in-servebolt-optimizer/
purge: EMAIL=${CLOUDFLARE_EMAIL}
purge: ZONE=${CLOUDFLARE_ZONE}
purge: API_KEY=${CLOUDFLARE_API_KEY}
purge:
	curl -X POST "https://api.cloudflare.com/client/v4/zones/$(ZONE)/purge_cache" \
		-H "X-Auth-Email: $(EMAIL)" \
		-H "X-Auth-Key: $(API_KEY)" \
		-H "Content-Type: application/json" \
		--data '{"purge_everything":true}'

get-zones: # ref https://api.cloudflare.com/#zone-properties
get-zones: EMAIL=${CLOUDFLARE_EMAIL}
get-zones: ZONE=${CLOUDFLARE_ZONE}
get-zones: API_KEY=${CLOUDFLARE_API_KEY}
get-zones:
	curl -X GET "https://api.cloudflare.com/client/v4/zones" \
		-H "X-Auth-Email: $(EMAIL)" \
		-H "X-Auth-Key: $(API_KEY)" \
		-H "Content-Type: application/json"
