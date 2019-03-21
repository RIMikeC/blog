---
layout:		post
title:       "Serverless Patterns"
subtitle:    "Write. Test. Release. Repeat."
description: "Working examples of serverless code in AWS"
date:        2019-03-21
author:      "Mike Charles"
draft: false
published: true
URL: "/2019/03/21/serverless-patterns"
image:       "https://raw.githubusercontent.com/RIMikeC/blog/master/prod/images/rockies.jpg"
tags:
    - AWS
    - serverless
    - lambda
categories:  ["Patterns"]
---

# Serverless Patterns

Anyone with infrastructure architecture experience worth their salt will tell you that patterns are incredibly important. Patterns establish "how" you achieve a goal in computing, by explicitly showing you exactily how it's been successfully achieved in the past.
A pattern could be anything from a single module of code, to a complete reference architecture for a complex global system. The scale is not important, its the fact that you have a cookie cutter at your fingertips, that you can use again and again, rather than starting from scratch. The power is in the reusability.

Ask anyone who's worked with me over the past twenty something years and they'll tell you that I love a pattern. My first archtiecture pattern (as far as I can remember), was a high level design for production Oracle databases. This was used to save time and effort in design process, but also helped us to automate Oracle admin processes post-implementation, as all our many instances started to look the same.

Ask anyone who's worked with me since April 2015, and they'll tell you that I'm a staunch advocate of serverless computing. So, of course, I'm going to love a serverless pattern. Here are some of the ones I find most useful.


