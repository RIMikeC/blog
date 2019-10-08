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

![async](https://raw.githubusercontent.com/RIMikeC/blog/master/prod/images/asyncmsg.png)

So, rather than pushing data to Microservice 2 via its API, Microservice 1 synchronously pops the data as a message onto a queue that Microservice 2 has created for this pupose. Microservice 2 uses a synchronous call to read the next message from the queue and then deletes it if it is valid. Note that both microservices uses synchronous calls, which are easy to program, but the net effect is that of an asynchronous communication pattern, as the two participants are independent of each other. I've shown a lambda picking up the message in the diagram, but it could equally be a process on an EC2 instance, such as an ECS task.

(What happens if the message is invalid will be the subject of a later post, let's keep it simple for now!)

The Terraform to create the queue couldn't be simpler

````hcl
resource "aws_sqs_queue" "example" {}
````

The full code, can be found [here](https://github.com/RIMikeC/patterns)


# Pattern Two - Fan Out
The second pattern is almost as simple. If a message is useful to more than one consumer, then use the fan-out. So here the producer put the message onto a topic, rather than a queue. It's possible to configure several consumers to a topic, but this has the effect to coupling all of the consumers together. They have to agree on the current state in order for the whole system to work. Betters is to have queues consuming from the topic and then lambdas picking from the queues.


![fanout](https://raw.githubusercontent.com/RIMikeC/blog/master/prod/images/fanout.png)

By using this pattern, you can scale from one to  many subscriber effortlessly and they will all execute indepently of each of each and of the consumer. If a subscriber slows down or even goes off line, then the others will carry on regardless.

# Pattern Three - Key Value Store CRUD

This pattern seems so simple, so it baffles me as to why so many people get it completely wrong. The problem being solved is how to apply CRUD operations to a relatively simple storage subsystem. 
This is often implemented in one of three way (see if you can work out why *they are all WRONG*!)
1. Let the client call the DynamoDB API directly form the Internet
1. The client calls an API which invokes a lambda function to perform the operation
1. Create a two tier application ie a new EC2 instance controlling the DynamoDB table, just for simple CRUD operations
This is the optimal solution:

![CRUD](https://raw.githubusercontent.com/RIMikeC/blog/master/prod/images/keyvaluecrud.png)
The client hits a RESTful API, which is served by API Gateway. API Gateway handles the authentication and throttling and then passes the command straignt through to Dynamodb, without having to create an instance or lambda in bewtween. This is particularly good for presenting information across the Internet in a way that easy for clients to consume, just by hitting a URI.

<table>
 <tr>
  <th>CRUD Operation</th>
  <th>API Method</th>
  <th>DynamoDB Action</th>
 </tr>
 <tr>
  <th>C reate</th>
  <th>POST</th>
  <th>PutItem</th>
 </tr>
 <tr>
  <th>R ead</th>
  <th>GET</th>
  <th>GetItem</th>
 </tr>
 <tr>
  <th>U pdate</th>
  <th>PUT</th>
  <th>PutItem</th>
 </tr>
 <tr>
  <th>D elete</th>
  <th>DELETE</th>
  <th>DeleteItem</th>
 </tr>
</table>

# Lambda as an Application Layer Target
AWS only provide one mechanism for load balancing layer 7 traffic, the Application load Balancer (ALB). There are now many cases for ALBs, the most common being:
1. In front of EC2 instances serving HTTP or HTTPS
1. In front of ECS or other container services
An emerging use case is an interesting serverless option, namely using lambda as an application target.

![ALB](https://raw.githubusercontent.com/RIMikeC/blog/master/prod/images/lambdaapptarget.png)
The ALB uses path-based routing to select which lambda to invoke.
