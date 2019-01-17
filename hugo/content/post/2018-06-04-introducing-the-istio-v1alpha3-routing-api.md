---
showonlyimage: true
title:      "Istio v1aplha3 routing API介绍(译文）"
subtitle:   ""
excerpt: "介绍Istio v1alpha3 routing API及其设计原则"
description: "介绍Istio v1alpha3 routing API及其设计原则"
date:       2018-06-04
author:     "赵化冰"
image: "https://img.zhaohuabing.com/in-post/2018-06-04-introducing-the-istio-v1alpha3-routing-api/background.jpg"
published: true 
tags:
    - Istio 

categories: [ Tech ]
URL: "/2018/06/04/introducing-the-istio-v1alpha3-routing-api/"
---

到目前为止，Istio提供了一个简单的API来进行流量管理，该API包括了四种资源：RouteRule，DestinationPolicy，EgressRule和Ingress（直接使用了Kubernets的Ingress资源）。借助此API，用户可以轻松管理Istio服务网格中的流量。该API允许用户将请求路由到特定版本的服务，为弹性测试注入延迟和失败，添加超时和断路器等等，所有这些功能都不必更改应用程序本身的代码。

<!--more-->
虽然目前API的功能已被证明是Istio非常引人注目的一部分，但用户的反馈也表明，这个API确实有一些缺点，尤其是在使用它来管理包含数千个服务的非常大的应用程序，以及使用HTTP以外的协议时。 此外，使用Kubernetes Ingress资源来配置外部流量的方式已被证明不能满足需求。

为了解决上述缺陷和其他的一些问题，Istio引入了新的流量管理API v1alpha3，新版本的API将完全取代之前的API。 尽管v1alpha3和之前的模型在本质上是基本相同的，但它并不向后兼容的，基于旧API的模型需要进行手动转换。 Istio接下来的几个版本中会提供一个新旧模型的转换工具。

