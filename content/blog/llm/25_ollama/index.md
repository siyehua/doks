---
title: "本地大模型-一调用 API"
description: "GPU,AI,本地大模型,AIGC,Developer"
summary: "AIGC 学习指路"
date: 2025-03-05T11:52:37+08:00
lastmod: 2025-03-05T11:52:37+08:00
draft: false
weight: 25
categories: []
tags: []
contributors: []
pinned: false
homepage: false
---

## 主题

- 本地部署的 Ollama 通过 API 访问

## 学习目标

* 通过API 访问 Ollama
* API 标准与其他 AI 的 API
* 聚合 API 介绍

## 通过 API 访问 LLM

前几篇文章讲解了通过如何自己部署本地 LLM，以及如何在界面上使用，但是往往我们还需要通过接口来提供给业务方。
比如说智能客服这种，通过是业务通过请求接口来实现的，我们不能指望用户按照你的 APP，你就运行一个 LLM 多模型，或者是用户只是
打开了一个网页，就跑起来了一个大模型。

而封装从接口给业务方的时候，就需要通过调用 LLM 的 API 来实现，当然我们自己通过编写 Python 的代码，然后提供一共 API 也是可以的，
但是现在所有的 LLM 都提供了 API，就没必要重复造轮子了。

### 对话生成

先来看官方的描述，请求一个对话：

```shell
curl http://localhost:11434/api/generate -d '{
  "model": "llama3.2",
  "prompt": "Why is the sky blue?",
}'
```

其中 `http://localhost:11434` 是你的 Ollama 服务器地址与端口号，Ollama 默认是 `11434` 端口，`model` 指的是模型，我们在最开篇的文章讲到，我们
部署的是 `deepseek-r1:7b`, `prompt` 就是用户的提问。

这 api 我们使用 python 请求是这样的：

```python
import requests
import json

from sqlalchemy import false

def test_chromadb():
    # 设置请求的 URL 和数据
    url = "http://localhost:11434/api/generate"
    data = {
        "model": "deepseek-r1:7b",
        "prompt": "Why is the sky blue?",
        'stream': False,
    }

    # 将数据转换为 JSON 格式
    headers = {"Content-Type": "application/json"}

    # 发送 POST 请求
    with requests.post(url,data=json.dumps(data), stream=False, headers=headers) as response:
        for line in response.iter_lines():
            if line:
                print(json.loads(line).get("response"))


# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    test_chromadb()

```

结果如下：

```
<think>
Okay, so I want to understand why the sky appears blue. I remember when I was a kid, my dad used to tell me that it's because of something called Rayleigh scattering. But now that I think about it more deeply, maybe there's more to it than just one reason. Let me try to break this down.

First off, light is made up of different colors, right? And blue is one of those colors. When sunlight reaches Earth's atmosphere, it passes through the air molecules and atoms in the upper atmosphere. Now, these particles scatter the light. But why does only blue get scattered?

I think it has something to do with the wavelength of the light. Blue light has a shorter wavelength compared to other colors like red or orange. So maybe when sunlight enters the atmosphere, the shorter wavelengths are more affected by the air molecules than longer ones. That would mean blue gets scattered more, making the sky look blue.

But wait, I've heard that during sunrise and sunset, the sky turns into different colors like red or orange. Why is that? Is it because of something else happening then? Maybe Rayleigh scattering isn't as dominant at those times?

Oh right! I think during sunrise and sunset, the light has to travel through a much larger part of the atmosphere. That longer path means more molecules can absorb the blue light, leaving the longer wavelengths like red, orange, and yellow to dominate. So it's called "Mie scattering" or something else? Maybe that's another factor.

So putting this together: when sunlight enters Earth's atmosphere, shorter wavelengths (blue) are scattered by air molecules, making the sky appear blue under normal conditions. But during sunrise and sunset, because the light has a longer path to travel through the atmosphere, the shorter wavelengths get absorbed more, allowing the longer ones to reach our eyes, resulting in colors like red, orange, or yellow.

Wait, but why does blue have that short wavelength? Is it because of the way white light is composed? White light is made up of all the visible spectrum, from violet to red. Violet has the shortest wavelength and red has the longest. So maybe when sunlight enters Earth's atmosphere, the shorter wavelengths get scattered more easily by the air molecules than the longer ones.

Another thought: if we lived at a higher altitude where the atmosphere was thinner, would the sky appear differently? Maybe because less light would be scattered or absorbed as it passes through.

Also, how does pollution affect this? If there's a lot of smoke or particles in the air, could that change which colors are predominant in the sky?

I'm trying to remember if there are other factors. Oh, maybe Rayleigh scattering is also wavelength-dependent but inversely proportional to the fourth power of the wavelength. That means blue (shorter) gets scattered more than red.

So, during clear skies without much pollution or particles, the sky is blue because of Rayleigh scattering. But when there's pollution, perhaps more reds appear because the scattering is affected by particulates and so on.

Wait, but I also heard that at higher altitudes like in mountainous areas, the sky looks different. Maybe it's less blue? Or maybe a different color altogether?

In summary, my understanding is:

1. Sunlight contains all colors of the spectrum.
2. When it passes through Earth's atmosphere, shorter wavelengths (blue/violet) are scattered more due to Rayleigh scattering.
3. This scattering makes the sky appear blue under normal conditions.
4. During sunrise and sunset, longer wavelengths (red/orange/yellow) dominate because they're less scattered or absorbed as light travels through a larger atmosphere.

But I'm still not entirely sure about all these points. Maybe some of them are oversimplifications? For example, does Rayleigh scattering account for the entire reason why the sky is blue, or are there other factors?

Also, when the sun is lower in the horizon during sunrise and sunset, the light has to pass through more atmosphere layers before reaching us. That might cause more absorption of shorter wavelengths by molecules or ozone, perhaps? Or maybe it's just that with longer paths, the scattering effect averages out differently.

I should probably look into whether Rayleigh scattering alone is sufficient to explain the blue sky and the other colors during sunrise/sunset, or if there are additional mechanisms involved. Maybe Mie scattering plays a role when particles in the atmosphere are larger than the wavelength of light? That could cause different scattering effects at different times of the day.

So, to wrap this up, I think the primary reason for the blue sky is Rayleigh scattering from shorter wavelengths (blue) being scattered more by air molecules. During sunrise and sunset, Mie scattering or other absorption processes cause longer wavelengths to dominate, resulting in colors like red, orange, and yellow.
</think>

The color of the sky appears blue primarily due to a phenomenon known as Rayleigh scattering. Here's a detailed explanation:

1. **Sunlight Composition**: Sunlight is composed of various colors across the visible spectrum, from violet (shortest wavelength) to red (longest wavelength).

2. **Atmospheric Scattering**:
   - When sunlight enters Earth's atmosphere, it interacts with molecules and small particles in the air.
   - Rayleigh scattering, a type of light scattering, is more effective for shorter wavelengths (blue/violet) than longer ones (red). This is because Rayleigh scattering intensity decreases with the fourth power of wavelength.

3. **Blue Sky Formation**:
   - Due to this scattering effect, blue light from the sun is scattered in all directions by air molecules.
   - Our eyes are more sensitive to blue light, making the sky appear blue during the day when sunlight reaches us through a shorter path.

4. **Sunrise and Sunset Colors**:
   - During sunrise and sunset, the light has to travel through a much larger part of Earth's atmosphere.
   - This longer path allows for Mie scattering or absorption by ozone (O₃) in the stratosphere, which preferentially absorbs blue light while allowing longer wavelengths (red, orange, yellow) to reach our eyes.

5. **Altitude and pollution Effects**:
   - At higher altitudes with thinner atmospheres, Rayleigh scattering may be less prominent, potentially affecting sky colors.
   - Pollution or particulate matter can influence light scattering, potentially leading to different predominant colors in the sky.

In summary, the blue color of the sky is primarily due to Rayleigh scattering of shorter wavelengths by air molecules. During sunrise and sunset, Mie scattering and absorption processes dominate, resulting in red, orange, or yellow hues.

```

### 识图能力

样式：

```shell
curl http://localhost:11434/api/generate -d '{
  "model": "llava",
  "prompt":"What is in this picture?",
  "stream": false,
  "images": ["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"]
}'
```

转成 Python 后：

```python
def download_image(url):
    """
    根据指定 URL 下载图片并返回图片内容。
    """
    try:
        response = requests.get(url)
        response.raise_for_status()  # 检查请求是否成功
        return response.content
    except requests.RequestException as e:
        print(f"Error downloading image: {e}")
        return None


def image_to_base64(image_data):
    """
    将图片数据转换为 Base64 编码。
    """
    try:
        # 使用 BytesIO 将图片数据转换为内存中的文件对象
        image = Image.open(BytesIO(image_data))
        buffered = BytesIO()
        image.save(buffered, format="PNG")  # 保存为 PNG 格式
        img_str = base64.b64encode(buffered.getvalue()).decode("utf-8")
        return img_str
    except Exception as e:
        print(f"Error converting image to base64: {e}")
        return None



def test_image():
    url = "https://img2.baidu.com/it/u=1093890935,1920906750&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1427"  # 替换为你的图片 URL
    image_data = download_image(url)

    if image_data:
        base64_image = image_to_base64(image_data)
    # 设置请求的 URL 和数据
    url = "http://localhost:11434/api/generate"
    data = {
        "model": "deepseek-r1:7b",
        "prompt": "这张图片是什么？",
        'stream': False,
        "images": [
            base64_image
        ]

    }

    # 将数据转换为 JSON 格式
    headers = {"Content-Type": "application/json"}

    # 发送 POST 请求并启用流式处理
    with requests.post(url, data=json.dumps(data), stream=False, headers=headers) as response:
        for line in response.iter_lines():
            if line:
                print(json.loads(line).get("response"))
```

结果提示不支持解析图片：


```
我无法直接查看或分析图片内容。如果你能提供图片的描述、文字或链接，我可以帮助你解答相关问题！
```

`DeepSeek` 目前还不支持解析图片，我们改成 `llama3.2-vision` 就支持多模态。根据前面的内容，我们先把前文的大模型下载下来，地址如下
https://ollama.com/library/llama3.2-vision

（注意：11b 比较大，对硬件要求比较高，建议必备比较强的下载线路，已经运行的 GPU）


```shell
ollama run llama3.2-vision:11b
```

把上面的 DeepSeek 的模型换成 `llama3.2-vision:11b` 即可：

```python
data = {
        "model": "llama3.2-vision:11b",
        "prompt": "这张图片是什么？",
        'stream': False,
        "images": [
            base64_image
        ]

    }
```

```
这是一张照片，显示了一名女性站在海滩上，向海洋望着。

背景是蓝天和大海，背景中可以看到一些岛屿或岩石。该照片可能拍摄于海滩或度假村等地方。
```

还有更多的 API 以及用法就不一一说了，感兴趣的同学可以自己前往官网查看：https://github.com/ollama/ollama/blob/main/docs/api.md


多模态的转换是非常有用的，我们如果做知识库的时候，经常会遇到视频，图片等需要解析的场景，这些都需要用到多模态功能

## API 标准与其他 AI 的 API

LLM 主要是有 OpenAI 引领了整个 AI 的浪潮，目前整个可以说整个 AI 界所有的开发者文档的 API，都基本跟 OpenAI 的类似。

* OpenAI: https://platform.openai.com/docs/api-reference/introduction
* Genmini: https://ai.google.dev/gemini-api/docs/text-generation?hl=zh-cn&lang=rest
* 豆包：https://www.volcengine.com/docs/82379/1298454
* Kimi: https://platform.moonshot.cn/docs/api/chat#%E5%8D%95%E8%BD%AE%E5%AF%B9%E8%AF%9D

可以看到这几个LLM 的 API 基本上是相似的，有的比较小的 LLM 厂商，干脆就直接对齐 OpenAI 的 API ，可以做到无缝衔接语切换，
比如 Kimi 就推荐你使用它封装好的SDK ，可以无缝的调用：https://platform.moonshot.cn/docs/guide/migrating-from-openai-to-kimi#%E5%85%B3%E4%BA%8E-api-%E5%85%BC%E5%AE%B9%E6%80%A7


## 聚合 API 介绍


除了上面我们说的各大厂商的 SDK, 或者 API 直接请求，通常还有一些项目，聚合了各大厂商的 API，可以直接调用，比如 Ollama 可以说就是
各个LLM 的聚合，它提供了一套标准的调用规范，只要按照它这套标准，就可以无缝的调用各个 LLM 的功能。

除了它之前，之前我们介绍的各个LLM 框架，基本上也封装好了，当然，还有一下网页的封装，例如：

* One-API: https://github.com/songquanpeng/one-api
* Open-WebUI: https://github.com/open-webui/open-webui
* AI-suite: ttps://github.com/andrewyng/aisuite

这些项目各自有各自的特点，大家根据自己的需要安装部署即可。
