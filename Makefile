# This is my blog Makefile
#
# BTW - to get the latest version from github, use "get blog"

# Push what is built in the dev directory to the Github repo

repo:
	( git add -A ; git commit -m stuff ; git push )

# Build the website in the prod directory and push it to s3

prod:	dev/content/post dev/static
	( cd prod ; rm -rf * )							# Remove everything in prod
	( cd dev  ; hugo -t hugo-theme-cleanwhite -d ../prod )			# Build a website from dev
	( cd prod ; aws s3 sync . s3://mikecharl.es/ --region eu-west-1 )	# Push changes to s3 bucket

test:	
	cd dev && hugo serve -t hugo-theme-cleanwhite

.PHONY:	repo test
