# This is my blog Makefile
#
# BTW - to get the latest version from github, use "get blog"

# Push what is built in the dev directory to the Github repo

repo:
	( git add -A ; git commit -m stuff ; git push )

# Build the website in the prod directory and push it to s3

prod:	dev
	( cd prod ; rm -rf * )
	( cd dev ; hugo -t hugo-theme-cleanwhite -d ../prod )
	( cd prod ; aws s3 sync . s3://mikecharl.es/ --region eu-west-1 )


.PHONY:	repo
