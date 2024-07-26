---
header:
  overlay_image: /assets/images/code.jpg
  caption: "Photo credit: [**Marcus Spiske**](https://unsplash.com)"
permalink: /portfolio/flow_matching_tortoisetts/
date: 2024-07-10
toc: true
toc_label: "Contents"
---

# Flow Matching Tortoise: Apply Optimal-Transport Flow Matching to TortoiseTTS

I've been fascinated by Flow Matching over the past few weeks. After diving into several research papers, I started wondering how I could apply Flow Matching to my field of expertise—speech synthesis. I found that TortoiseTTS, a large language model (LLM) based text-to-speech system, which seemed like the perfect candidate. In this project, I aim to replace the existing diffusion model in TortoiseTTS with a Flow Matching model while maintaining the high-quality audio output.

## TortoiseTTS Architecture

Since many readers might not be familiar with the TortoiseTTS model, let's briefly explore its architecture to provide some context.

TortoiseTTS consists of a series of sub-models, each trained separately in a specific sequence. Here's a breakdown of these sub-models:

- **VQVAE**: Encodes audio into tokens.
- **AR Model**: Performs text-to-audio-token modeling.
- **Diffusion Model**: Generates Mel-spectrograms from the AR model's latent representations.
- **Vocoder**: Converts Mel-spectrograms into audio.

<figure style="text-align: center;">
    <img src="{{ '/assets/images/tortoise_arch.png' | absolute_url }}" width="60%" style="display: block; margin: 0 auto;">
    <!-- <figcaption style="text-align: center;">Probability density path 2</figcaption> -->
</figure>

In this project, I aim to replace the Diffusion Model with a Flow Matching model while leaving the other components unchanged.

## Experiment and Result

The original diffusion model in TortoiseTTS was trained using a massive dataset of **65 million** audio samples. Unfortunately, I don't have access to a dataset of that magnitude. Instead, I used LibriTTS, which is relatively small in comparison, to train the Flow Matching model. Additionally, in order to make the comparison between Diffusion and Flow Matching as much fair as possible, I reused the architecture if Diffusion model in TortoiseTTS to train Flow Matching model. 

Here are some audio samples from TortoiseTTS after replacing the Diffusion Model with the Flow Matching model. Take a listen and see how the new model performs!

<p><b> Example 1: Text: </b><em class="text">Forty one percent of enterprises that have already deployed generative AI expect to increase the adoption of open-source models when they match performance with the leading proprietary models.</em></p>
<p><span class="text">Prompt</span></p>
<td><audio controls preload="none" class="id"><source src="/assets/audios/1.wav"></audio></td>
<table>
    <tbody>
        <tr>
        <th>Diffusion - 2 steps</th>
        <th>Flow Matching - 2 steps</th>
        </tr>
        <tr>
        <td><audio controls preload="none" class="id"><source src="/assets/audios/1_prompt_diff_2.wav"></audio></td>
        <td><audio controls preload="none" class="id"><source src="/assets/audios/1_prompt_fm_2.wav"></audio></td>
        </tr>
    </tbody>
</table>

From the results, we can clearly see that Flow Matching generates audio of decent quality with fewer steps than the Diffusion model. This means that Flow Matching can achieve the same level of quality more quickly. I also want to emphasize that my Flow Matching model was trained using a much smaller dataset compared to the one used for Diffusion. Despite this, the audio quality produced by Flow Matching is often on par with, if not better, that of the Diffusion model. This indicates that Flow Matching can be much more data-efficient than the Diffusion model.

However, I do believe that my Flow Matching model is inferior to the Diffusion model in some aspects due to the lack of training data. One of these aspects is voice cloning capability—the speaker similarity between the prompt and the synthesized voice. The Diffusion model in TortoiseTTS was trained on **65 million** samples, which likely cover a greater variety of speakers than LibriTTS. But I am confident that with access to the same amount of data used to train the Diffusion model, Flow Matching could perform much better in terms of speaker similarity.