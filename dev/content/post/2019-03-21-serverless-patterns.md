---
layout:		post
title:       "Serverless Patterns"
subtitle:    "Déjà vu"
description: "Working examples of serverless code in AWS"
date:        2019-03-21
author:      "Mike Charles"
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
A pattern could be anything from a single module of code, to a complete reference architecture for a complex global system. The scale is not important, its the fact that you have a cookie cutter at your fingertips, that you can use again and again, rather than starting from scratch. *The power is in the reusability*.

Ask anyone who's worked with me over the past twenty something years and they'll tell you that I love a pattern. My first archtiecture pattern (as far as I can remember), was a high level design for production Oracle databases. This was used to save time and effort in design process, but also helped us to automate Oracle admin processes post-implementation, as all our many instances started to look the same.

Ask anyone who's worked with me since April 2015, and they'll tell you that I'm a staunch advocate of serverless computing. So, of course, I'm going to love a serverless pattern. Here are some of the ones I find most useful.

# Pattern One - Decoupling Two Microservices
Microservices are, by their very nature, independent of each other. Or rather, that is how they are *supposed* to work. In fact its very easy to build microservcies that rely on a common service, so when that service is interrputed, the micorservies suffer. Another common problem is that people build a microservice, then only build a synchronous API around it. So, if the microservice slows down or dies altogether, every microservice that call the synchronous API also immediately suffers.

The way round this is to de-couple your microservices, typically using a message queue. Message queues are implmented in AWS using one of the oldest services - the Simple Queueing Service (SQS).

![sqs](https://raw.githubusercontent.com/RIMikeC/blog/master/prod/images/sqs.png)

So, rather than pushing data to Microservice 2 via its API, Microservice 1 synchronously pops the data as a message onto a queue that Microservice 2 has created for this pupose. Microservice 2 uses a synchronous call to read the next message from the queue and then deletes it if it is valid. Note that both microservices uses synchronous calls, which are easy to program, but the net effect is that of an asynchronous communication pattern, as the two participants are independent of each other. I've shown a lambda picking up the message in the diagram, but it could equally be a process on an EC2 instance, such as an ECS task.

(What happens if the message is invalid will be the subject of a later post, let's keep it simple for now!)

The Terraform to create the queue couldn't be simpler

````hcl
resource "aws_sqs_queue" "example" {}
````

The full code, can be found [here](https://github.com/RIMikeC/patterns)

