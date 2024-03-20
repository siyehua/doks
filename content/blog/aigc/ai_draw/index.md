---
title: "开发者 AI 绘画入门"
description: "GPU,AI,AI绘画,在线生图"
summary: "介绍一下 AI 绘画的现状，基础知识，如何部署，使用等"
date: 2024-03-18T19:57:31+08:00
lastmod: 2024-03-18T19:57:31+08:00
draft: false
weight: 2
categories: []
tags: []
contributors: []
pinned: false
homepage: false
---

关于 AI 绘画的文章太多了，建议大家先直接从网上搜索，我这里就不展开了，这边文章主要是针对开发者的，设计，产品等同学可以在 B 站，知乎等地方搜索更多资料<br>

推荐一篇我看的：
[超详细！AI 绘画神器 Stable Diffusion 基础教程](https://www.uisdc.com/stable-diffusion-2)

## AI 绘画种类
AI 绘画领域包含了多种技术，每种技术都有其独特的应用场景和创作风格。主要的种类有：

* 生成对抗网络 (GANs): 通过对抗过程生成高质量的图像。
* 变分自编码器 (VAEs): 生成与训练数据类似的新图像，但带有变化。
* 神经风格迁移: 将一种艺术风格应用到其他图像上。
* Diffusion 模型: 通过模拟扩散过程来生成细节丰富的图像。
* Transform 模型: 利用自注意力机制生成高质量的图像。

这几类技术都有比较典型的代表，发展至今，目前市面上有三大主流绘画是比较好的，它们分别是：

### Stable Diffusion 技术

* 技术原理：Stable Diffusion 是基于 Diffusion 模型的改进版本，它通过引入隐向量空间来解决原始 Diffusion 模型的速度瓶颈问题。Stable Diffusion 能够处理多种图像生成任务，包括文生图（text to image）、图生图（image to image）、特定角色刻画、超分辨率和上色等。
* 开源属性：Stable Diffusion 是一个完全开源的项目，包括模型、代码、训练数据、论文和生态等。这使得它能够快速构建一个强大且繁荣的上下游生态，吸引了众多 AI 绘画爱好者和行业从业者的参与。
* 应用范围：由于其开源和免费的特性，Stable Diffusion 被广泛应用于个人项目、研究和商业用途，促进了 AI 绘画技术的普及和发展。

**可以说，目前国内的绘画基本上都是基于 Stable Diffusion 的技术进行改造升级的。**
![sd](sd.png)
但是 Stable Diffusion 不能开箱即用，需要配置好用的模型以及参数设置，才能生成好看的图片，它是三个绘画中最复杂的，但是也是控制图片最精确的。

### Midjourney 技术
* 技术原理：Midjourney 是一个 AI 绘画平台，它使用自己的专有技术和算法来生成图像。虽然具体的技术细节没有公开，但它被认为在生成图像的艺术度方面表现出色。
* 用户体验：Midjourney 提供了一个用户友好的界面，允许用户通过简单的文本提示来生成图像。它在艺术创作和设计领域中得到了广泛的应用。
* 商业模型：Midjourney 是一个付费服务，用户需要订阅才能使用其全部功能。

Midjourney 是目前公认的最好的生图模型，生成的照片都非常漂亮，只需要使用非常简单的 prompt 与指令，就能生成非常好看的图片。
![mj](mj.png)

由于 Midjourney 不开源，在国内也无法使用，所以对于我们开发者来着，其实不太需要了解它，如果需要转接它的 API 就是另外一回事了。

### DALL·E 3 技术
* 技术原理：DALL·E 3 是由 OpenAI 开发的 AI 系统，它使用了变分自编码器（VAE）和 Transformer 架构来生成图像。DALL·E 3 特别擅长理解复杂的文本提示，并生成与之相匹配的高质量图像。
* 图像质量：DALL·E 3 在图像的连续性和对提示词的理解方面表现出色，其生成的图像质量被认为是非常高的。
* 商业模型：DALL·E 3 是 OpenAI 提供的服务，用户可以通过 API 访问，但需要付费使用。

DALL·E 3 生成的图片并不是最好看的，由于它也是闭源的，对我们开发者来说也没什么好研究的，可以看看它的[原理](https://finance.sina.cn/blockchain/2023-10-24/detail-imzsemws3376148.d.html)
![dalle](dalle.png)

虽然 DALL·E 3 对比上面两个的优点它都没有，但是它对于文本的理解远超上面两个绘画。这是非常重要的，我们将会在下面详细讲解。

## 绘画基础知识
绘画目前主要有两种形式： `文生图` 或 `图生图`， 这里以 Stable Diffusion 为例，讲解一下文生图的大概原理：<br>
* 首先，输入 Prompt 提示词 “paradise, cosmic, beach”，经过 Text Encoder 组件的处理，将输入的 Prompt 提示词转换成 77×768 的 Token Embeddings，该 Embeddings 输入到 Image Information Creator 组件；
* 然后，Random image information tensor 是由一个 Latent Seed（Gaussian noise ~ N(0, 1)） 随机生成的 64×64 大小的图片表示，它表示一个完全的噪声图片，作为 Image Information Creator 组件的另一个初始输入；
* 接着，通过 Image Information Creator 组件的处理（该过程称为 Diffusion），生成一个包含图片信息的 64×64 的 Processed image tensor，该输出包含了前面输入 Prompt 提示词所具有的语义信息的图片的信息；
* 最后，上一步生成的 Processed image tensor 信息经过 Image Decoder 组件处理后生成最终的和输入 Prompt 提示词相关的 512×512 大小的图片输出。<br>

<br>简单点理解就是：<br>
用户输入一段文字描述：`Create a beautiful girl`，交给生图模型，然后生图模型根据对文本的理解，模型根据算法模型，生成了一张图片：<br>

![create](create.png)

`图生图` 也类似, 我们看一下大概的原理：

![sd_2.png](sd_2.png)

相关资料：<br>
http://shiyanjun.cn/archives/2212.html <br>
https://zhuanlan.zhihu.com/p/583124756 <br>
https://xie.infoq.cn/article/2c72b3695a030af45ac30acc5 <br>

### 底层流程

![sd_3.png](sd_3.png)

### 应用层流程

![draw_01.png](draw_01.png)


根据上面的介绍我们知道，AI 的模型是非常重要的，不同的 AI 生图模型处理的方式与技术，算法都不相同，对于 AIGC 的开发者来说，
我们首先要熟悉它的生图流程，而生图流程中，`prompt`,即文字提示，几乎是最重要的一环。<br>
关于如何写好 prompt，请看下面的介绍。

## 如何部署



### Windows
### Mac
### Linux/服务器
### 其他云端
## 简单使用
## 理解 Diffusion 模型
## 理解 Transform 模型
## 如何写绘画 prompt?
## 学习网站
## 模型网站
