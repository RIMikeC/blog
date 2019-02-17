#!/bin/bash


cd ~/blog/hugo/public

find . -print | \
 xargs -I {} aws s3 cp {} s3://nomoreservers/www/{} --region eu-west-2

