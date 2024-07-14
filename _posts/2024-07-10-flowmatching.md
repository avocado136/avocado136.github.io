---
title:  "A Friendly Guide to Flow Matching in Deep Learning"
category: posts
date: 2024-07-10
excerpt: "How I understand flow matching in theory and practice."
comments: true
---

Flow Matching has been generating significant buzz in the AI community lately. This innovative technique is poised to replace the highly successful Diffusion modeling and has already been integrated into cutting-edge models like Stable Diffusion 3, Resemble Enhance, and E2TTS. Intrigued by its potential, I decided to delve into the world of Flow Matching to understand how exactly it works in theory and practice.

Over the past few weeks, I immersed myself in learning about the concept of Flow Matching. While the journey was enjoyable, the concept proved to be quite abstract and challenging to understand. In this blog post, I aim to demystify Flow Matching and present it in a straightforward manner that anyone can follow. I hope someone would find this useful!

# Diffusion Recap and Motivation of Flow Matching
Most of us are probably somewhat familiar with the concept of the diffusion process in diffusion-based models. Let's refresh real quick.

<figure>
<img src="{{ "/assets/images/forward_diff.png" | absolute_url }}"
width="60%" hspace="1" align="left">
<figcaption> Forward diffusion process </figcaption>
</figure>
<figure>
<img src="{{ "/assets/images/reverse_diff.png" | absolute_url }}"
width="60%" hspace="1" align="left">
<figcaption> Reverse diffusion process </figcaption>
</figure>

In the forward diffusion process, noise is incrementally added to a data point over multiple steps. If enough steps are taken, the data point eventually transforms into complete noise. Conversely, the reverse diffusion process systematically denoises the noisy data point in multiple steps, reconstructing the original input.

Now, you might wonder: why do we need to specify processes to add and remove noise from data? Why not adopt a more general approach, where the goal is simply to transform a simple distribution (typically a Gaussian) into a target distribution? As long as we can find a way to get to target distribution, we’re good! This broader perspective is the motivation behind Flow Matching. We'll delve into the details in the upcoming sections.

# Flow Matching

Before diving into the concept of Flow Matching (FM), let’s define the foundational components that build the FM framework.

**Probability Density Path (p):**
$[0,1] \times \mathbb{R}^d \rightarrow \mathbb{R} (>0)$

Unlike a regular probability distribution, a probability density path is time-dependent (with time ranging from 0 to 1). At any given time and location, it provides the probability density of that specific location at that particular time. In deep learning,

p0 (the distribution at t=0) is a simple distribution, such as a Gaussian, while p1 (the distribution at t=1) represents the dataset distribution we aim to model.

**Vector Field (v):**
$[0,1] \times \mathbb{R}^d \rightarrow \mathbb{R}^d$

This constructs a flow $\phi$ defined by the Ordinary Differential Equation (ODE)

$\frac{d}{dt} \{ \phi_t(x) \} = v_t(\phi_t(x)) \quad (1)$
$\phi_0(x) = x \quad (2)$

The flow $\phi$ pushes $p_0$ along the time dimension so that at $t=1$, the probability density becomes $p_1$. This is represented by the push-forward equation:

$p_t = [\phi_t] * p_0$

To transition from a source distribution $p_0$ to a target distribution $p_1$, we need to understand the flow of the probability path. According to the ODE equation, $\phi_t$ is constructed by $v_t$. Therefore, to determine $\phi_t$, we only need to find $v_t$.

If this still feels abstract, imagine driving a car on a highway for the first time without prior knowledge of how to reach the exit. You start at the entrance ($p_0$) and follow a series of small arrows ($v_t$) painted on the road, guiding you to the exit ($p_1$).

<!-- ** Insert a figure of the highway example here **  -->
<figure>
<img src="{{ "/assets/images/ppath.jpg" | absolute_url }}"
width="60%" hspace="1" align="left">
<figcaption> Reverse diffusion process </figcaption>
</figure>

Now, let x1 denote a random variable distributed according to the approximate data distribution $p_1$, with $p_0$ being a simple distribution like a Gaussian. As mentioned, vt determines the probability path and the flow. If we know vt, we can transform $p_0$ into $p_1$. In other words, knowing vt allows us to model the data distribution $p_1$.

The Flow Matching objective is:
<!-- L(θ) = E_{t,pt(x)} ||vt(x) - ut(x) || ^ 2  -->
$L_FM(\theta) = E_{t, p_t(x)} ||v_t(x) - u_t(x)||^2$

where $v_t(x)$ is the “ground truth” vector field, and $u_t(x)$ is the estimated vector field from a neural network. Simply put, FM loss minimizes the difference between the vector field $v_t$ and the predicted $u_t$.

While this might seem straightforward, there's a significant problem: the FM objective is intractable. We don’t have a closed form for $v_t$ and $p_t$, which are what we’re trying to find. The solution to this issue is a method called Conditional Flow Matching.

# Conditional Flow Matching 
Given a dataset with $N$ datapoints $(x_{1_0}, x_{1_1}, x_{1_2}, \ldots, x_{1_N})$, it is nearly impossible to model the exact distribution of the dataset. However, we can approximate it by considering it as a mixture of simpler distributions.

We design a conditional probability distribution $p_1(x \mid x_1)$ at $t=1$ to be concentrated around $x=x_1$. For instance, $p_1(x \mid x_1)$ can be a normal distribution with mean $x_1$ and a very small standard deviation $σ$, such as $p_1(x \mid x_1) = N(x \mid x_1, \sigma^2I)$. The overall distribution $p_1(x)$ is then approximately a mixture of all these conditional probability distributions centered around each datapoint in the dataset.

<!-- ** Insert a figure as the visualizer here ** -->
<figure>
<img src="{{ "/assets/images/mixture.jpg" | absolute_url }}"
width="60%" hspace="1" align="left">
<figcaption> Reverse diffusion process </figcaption>
</figure>

The marginal probability $p_1(x)$ is represented as

<!-- p1(x) = intergral { p1(x|x1)q(x1)dx1} -->
$p_1(x) = \int p_1(x \mid x_1)q(x_1) \, dx_1$

Similarly, we can represent the probability path by marginalizing over the condition $x_1$:

  <!-- pt(x) = intergral { pt(x|x1)q(x1)dx1}     -->
$p_t(x) = \int p_t(x \mid x_1)q(x_1) \, dx_1$

We can also define the vector field $v_t$ by marginalizing over the conditional vector fields:
$p_t(x) = \int u_t(x \mid x_1)\frac{p_t(x \mid x_1) q(x_1)}{p_t(x)} \, dx_1$

This implies that while we don’t have a closed form for $v_t$, we can approximate it by aggregating all the conditional vector fields $v_t(. \mid x_1)$ according to all the datapoints.

** Insert a figure here ** 

So now we have the objective of CFM
$L_{CFM}(\theta) = E_{t, q(x_1), p_t(x \mid x_1)} \{v_t(x) - u_t(x \mid x_1)\}$
<!-- where t ∼ U[0, 1], x1 ∼ q(x1), and now x ∼ pt(x|x1). -->
where $t \sim U[0, 1]$, $x_1 \sim q(x_1)$, and now $x \sim p_t(x \mid x_1)$.

Unlike the FM objective, the CFM objective is tractable. We can sample from $p_t(x \mid x_1)$ and compute $u_t(x \mid x_1)$, both of which can be easily done as they are defined on a per-sample basis. So now we’re ready to train a CFM model with this objective, right? Well, not quite! If you notice, $p_t(x \mid x_1)$ only specifies a probability path that somehow flows from $p_0$ to the dataset distribution. However, there are countless possible paths that can flow from $p_0$ to $p_1$. Consequently, there are also countless possible vector fields. So among these infinite paths, which one should we use in practice? Let's dive into the next part to figure it out.

***Insert a figure here***

# CFM in practice 
When training a Conditional Flow Matching (CFM) model, we can use any shape or type of probability path. Ideally, the modeling capability remains the same regardless of the chosen path, meaning the model can theoretically reach the global optimum with any path. However, in practice, we prefer using a straight-line probability path for several reasons:
- Faster model convergence
- Fewer steps needed during inference to achieve the same quality, resulting in faster inference

The most commonly used type of CFM, at least at the time of writing, is Optimal Transport Conditional Flow Matching (OTCFM). In OTCFM, the conditional probability path and the conditional vector field are defined as:

<!-- 
    pt(x) = N(t*x1 + (1-t)x0, t(t-1)σ^2) 
    ut (x) = x1 - x0 -->
$p_t(x) = N(t \cdot x_1 + (1 - t) \cdot x_0, t \cdot (t - 1) \cdot \sigma^2)$

$u_t(x) = x_1 - x_0$

The straight-line probability path is represented by the mean $\mu = t \cdot x_1 + (1 - t) \cdot x_0$ of $p_t$. When $t$ is close to $0$, $x_t$ is close to $x_0$, and when $t$ is close to $1$, $x_t$ is close to $x_1$. At any time between $[0,1]$, $\mu is the interpolation of $x_1$ and $x_0$.

Below is the backbone of OTCFM in pseudo code if you ever wanna train a OTCFM model

(WIP)

# Conclusion
(WIP)



