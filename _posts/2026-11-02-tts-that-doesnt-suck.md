---
layout: post
title: TTS That Doesn't Suck
subtitle: "Fire BonziBuddy. Hire Kokoro."
date: 2026-11-02
tags: [work]
---

I utilize text-to-speech (TTS) when AI needs input from me or when it notifies me that it is done with something. I am not going to spend the time reading its output if I can avoid it. What am I, an animal? All the AI harnesses allow you to hook into events you care about and perform actions. I have it make announcements to me when it makes sense.

## TTS makes my ears bleed

However, one downside of these announcements is that the default TTS voices that are used make me want to kill myself. They give me [BonziBuddy](https://en.wikipedia.org/wiki/BonziBuddy) flashbacks from the 90s. Of course it was great fun to make BonziBuddy say expletives to you and your idiot friends when your parents weren’t around, but when you have AI making announcements dozens of times a day, it becomes *grating*. Fortunately, where there is an unnecessary and frivolous feature request, an even more needless solution is available!

## Kokoro to the rescue

Fortunately, [Kokoro](https://huggingface.co/hexgrad/Kokoro-82M) offers a small TTS model that sounds much more natural and less like a monkey from Silence of the Lambs (it is also free, requires no signup, and runs locally). It comes with more than 50 voices to choose from across several languages. I use [`kokoro-onnx`](https://github.com/thewh1teagle/kokoro-onnx) , which runs the model with ONNX Runtime instead of PyTorch (basically a small install that doesn’t make you install a bunch of other nonsense). I don’t know how to set it up, and neither do you. Just prompt with something like this:

> “With deference to my mental health, please switch all your TTS to utilize kokoro using kokoro-onnx”.

That should take care of it.

## Demos

{% include audio.html src="/assets/audio/posts/tts-that-doesnt-suck/macos-say.m4a" label="Default macOS `say`" %}

{% include audio.html src="/assets/audio/posts/tts-that-doesnt-suck/kokoro.m4a" label="Kokoro (`kokoro-onnx`, `af_heart` voice)" %}
