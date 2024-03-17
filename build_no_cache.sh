node_modules/.bin/hugo/hugo --cleanDestinationDir
rm -rf ./resources
node_modules/.bin/hugo/hugo server --bind=0.0.0.0 --disableFastRender --baseURL=http://localhost --noHTTPCache
