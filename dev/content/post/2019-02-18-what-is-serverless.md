---
layout:		post
title:		"What Is Serverless?"
subtitle:	"...and why you should care"
image:		"https://raw.githubusercontent.com/RIMikeC/blog/master/hugo/static/images/ldn.jpg"
author:		"Mike Charles"
published:	true
date:		2019-02-18T13:29:51Z
tags:
    - AWS
    - serverless
    - lambda
URL:		"/2019/02/18/what-is-serverless/"
categories:  ["Tech" ]
---


# What is Serverless?
Serverless computing is a service, that runs your code for you on a server that it determines.
Although your code runs on a server, the term "serverless" is used as the person who writes the code does not need to know anything about the server.  
It's a confusing term. There *are* servers in a serverless environment, of course there are. However, there is a clear separation of responsibilities between the people who manage the servers and the people who write the code that runs on them. They neither know, nor care, what each other is up to.
  
Serverless has been around for a few years now, but has recently gained popularity, thanks in no small part to AWS, who are gradually moving their services (and thus several million customers) to a serverless operating model.

### Is it faster?
#### Yes (and  no)
{:.no_toc}
A team of developers that never has to worry about provisioning, monitoring, patching or upgrading infrastructure is freed up to focus on making great software. This narrow focus means they'll deliver faster, so in that respect, serverless is faster. However, once the code is running, it's pretty much the same whether it is in a serverless or a traditional environment, so in that respect; serverleress is no faster.


### Is it cheaper?
#### Yes (and  yes)
{:.no_toc}
Writing software without having to specify, procure, install and configure servers means that the software delivery and testing cycles are significantly cheaper than they would otherwise be. Once the code is running, the costs are again reduced, for example, you no longer need over-provision in order to cope with peak demand.

### What does it look like?
Consider a normal infrastuture stack. There always room for some variation, but typically they look something like this:   
![full stack](https://raw.githubusercontent.com/RIMikeC/blog/master/hugo/static/images/fullstack.jpg)
If you need a complete stack in order to provide any value, then are all parts equally important? Should you spend an equal amount on each part of the stack? Well, you don't have to think deeply about the problem to realise that some parts of the stack are more important than others, but still it may not be immediately apparent as to where to focus limited resources. The best way to realise where to focus is to see where you can add value to your business.  
![part stack](https://raw.githubusercontent.com/RIMikeC/blog/master/hugo/static/images/full stack 2.png)
 Infrastructure, though vital, will never actually add any value. Value is only added by the applications you write and by your data.  
![part stack](https://raw.githubusercontent.com/RIMikeC/blog/master/hugo/static/images/full stack 3.png)
So now it's easy to see why serverless makes sense for modern businesses - it lets you focus on parts of the stack that add value, whilst consuming all the other (boring) parts as a service.  



