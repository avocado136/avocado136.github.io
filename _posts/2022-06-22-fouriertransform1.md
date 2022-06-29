---
title:  "Fourier Transform Through The Concept of Sampling (1)"
category: posts
date: 2022-06-22
excerpt: "Explaining all kinds of Fourier Transfrom using sampling method."
comments: true
---
<!-- 
figcaption {
  background-color: black;
  color: white;
  font-style: italic;
  padding: 2px;
  text-align: center;
} -->

# Fourier Transform Overview
In another post, [betterexplained](https://betterexplained.com/articles/an-interactive-guide-to-the-fourier-transform/) starts explaining Fourier Transform through the scope of a refreshing smoothie. Particularly, say we have a smoothie, now the question is, are we able to identify how much milk, the amount of water, how much veggies in that smoothie?

That problem statement is an excellent example of the motivation of Fourier Transform. The smoothie here is your signal $$x(t)$$ which consists of a bunch of frequency components (milk, water, veggies, .etc). Fourier Transform is an extremely powerful tool that helps us decompose signals in the time domain[^fnote1] into multiple frequency components from which we can analyze how each frequency contributes to the overall signal. Additionally, oftentimes there exists problems that are very difficult to solve in the time domain but become trivial in the frequency domain (or the other way around). That's why we need Fourier Transform as a tool to view the signals in different domains. 

Mathematically, Fourier Transform is defined as

<!-- $$X(f)= \mathcal{F}\{x(t)\} = \int_{-\infty}^{\infty} x(t)e^{-2\pi ift} dt$$ -->
$$
\begin{equation}
    X(f)= \mathcal{F}\{x(t)\} = \int_{-\infty}^{\infty} x(t)e^{-2\pi ift} dt
    \label{eq:inverse} \tag{1}
\end{equation}
$$

<!-- $$x(t)= \mathcal{F}\{X(f) \} = \int_{-\infty}^{\infty} X(f)e^{2\pi ift} df$$ -->

<!-- $$x(t)= \mathcal{F} \{X(f)\} = \int_{-\infty}^{\infty} X(f)e^{2\pi ift} dt$$ -->

$$
\begin{equation}
    x(t)= \mathcal{F} \{X(f)\} = \int_{-\infty}^{\infty} X(f)e^{2\pi ift} df
    \label{eq:forward} \tag{2}
\end{equation}
$$

Looks scary but equation \eqref{eq:inverse} (called forward Fourier Transform) just simply states that given a continuous function $$x(t)$$ in the time domain, applying the math, we get the frequency information $$X(f)$$ and vice versa in equation \eqref{eq:forward} (called inverse Fourier Transform).

However, the expressions above are just the generalized cases representing Fourier Transform at a very high level. To take a closer look, there are multiple variants of Fourier Transform: Fourier Series, Discrete-time Fourier Series, Discrete-time Fourier Transform, Discrete Fourier Transform, .etc. Each comes with different math equations and it’s frustrating to remember all of them. Therefore, this post will provide you with an intuitive, logical way to understand what’s going on under the hood without having to remember all the math regardless of whatever variant it is. We’ll dive into the concepts of Fourier Transform under the light of **_SAMPLING_**. Yes, **_SAMPLING_**’s gonna be the key to unlocking your in-depth understanding of Fourier Transform. 

# Sampling
First, let’s start with the _dirac comb_ function (can also be called _shah function_, _impulse train_) — an essential function in sampling. _Dirac comb_ is a periodic function with periodicity $$T$$ having the formula

$$
\begin{equation}
ш_{T}(t)=\int_{-\infty}^{\infty}\delta(t - kT)\\
          = \frac{1}{T}ш(\frac{1}{T})
\label{eq:diraccomb} \tag{3}
\end{equation}
$$

where $$\delta(t)$$ is an impulse function and $$ш(t)$$ implies a _dirac comb_ with unit period ($$period = 1$$).

Besides, _dirac comb_ function also has an interesting property that its Fourier Transform is another _dirac comb_ in the frequency domain with the period being the multiplicative inverse of its counterpart in the time domain.

<figure>
<img src="{{ "/assets/images/comb2.png" | absolute_url }}"
width="100%" hspace="1" align="left">
<figcaption>Fig.1 - Dirac comb in time domain (left) and its Fourier Transform (right). The scarcer it is in time the denser it is in frequency and vice versa.</figcaption>
</figure>

We all know that our computers cannot handle continuous data, so for them to understand, natural continuous-time signals need to be reduced to discrete-time signals. Specifically, the values of a continuous-time signal are extracted periodically at many points in time to form a sequence of discrete-time equally spaced values representing the original signals.

Mathematically, sampling is the process of multiplicating continuous-time signal with _dirac comb_:

$$
\begin{equation}
    x[t]=\frac{1}{T}ш(\frac{1}{T}) x(t)
    \label{eq:sampling} \tag{4}
\end{equation}
$$

<figure>
<img src="{{ "/assets/images/sampling.png" | absolute_url }}"
width="50%" hspace="1" align="left">
<figcaption>Fig.2 - Sampling is the multiplication of dirac comb and the continuous signal. Traditionally, we use [] amd () to represention discrete and continuous signal respectively. </figcaption>
</figure>

At this point, it is encouraged to keep in mind the 2 mantras that are the building blocks for everything that comes later

* Fourier Transform of a _dirac comb_ is also a _dirac comb_ $$\mathcal{F}\{\frac{1}{T}ш(\frac{t}{T})\} = {\frac{1}{F}ш(\frac{t}{F})}$$ for $$T=\frac{1}{F}$$

* **Convolution** in _time domain_ $$<=>$$ **multiplication** in the _frequency domain_ and vice versa

So far, we have collected all the powerful weapons. Now we're ready to go smash all kinds of Fourier Transforms down one by one.

# Fourier Series
Consider a finite continuous signal $$x(t)$$, and $$x_T(t)$$ is the periodic extension of $$x(t)$$ with period $$T$$.

<figure>
<img src="{{ "/assets/images/periodicsignal.png" | absolute_url }}"
width="50%" hspace="1" align="left">
<figcaption>Fig.3 - Finite continuous signal (left) and periodic continuous signal (right). </figcaption>
</figure>
    
So the question is what does the Fourier transform of periodic $$x_T(t)$$ look like? Is it also periodic? Is it continuous in the frequency domain? Can we intuitively know all these without googling for the math?

It may not seem informative when we look at the signal $$x_T(t)$$ only. But what about decomposing into small units? You may notice that $$x_T(t)$$ is just the convolution of $$x(t)$$ and _dirac comb_ $$\frac{1}{T}ш(\frac{t}{T})$$.

<!-- $$x_T(t)=\frac{1}{T}ш(\frac{t}{T})*x(t)$$ -->

$$
\begin{equation}
    x_T(t)=\frac{1}{T}ш(\frac{t}{T})*x(t)
    \label{eq:5} \tag{5}
\end{equation}
$$

Remember the two important properties discussed above? Fourier Transform of a _dirac comb_ is also a _dirac comb_ and _time-domain_ convolution is equivalent to _frequency-domain_ multiplication. Bringing them all to the frequency domain, we get

<!-- $$X [f] = \frac{1}{F}ш(\frac{t}{F})X(f)$$ -->

$$
\begin{equation}
    X [f] = \frac{1}{F}ш(\frac{t}{F})X(f)
    \label{eq:6} \tag{6}
\end{equation}
$$

where $$\mathcal{F}\{x_T(t)\} = X[f]$$ and $$\mathcal{F}\{x(t)\} = X(f) $$. 

It turns out that this is exactly the form of sampling (equation \eqref{eq:sampling}). The only difference is that **_signal is now sampled in the frequency domain_** instead of the time domain.

<figure>
<img src="{{ "/assets/images/fs.png" | absolute_url }}"
width="60%" hspace="1" align="left">
<figcaption>Fig.4 - Fourier Transform of continuous periodic signal. </figcaption>
</figure>

Until now, the big picture should be crystal clear. Fourier Transform of a continuous periodic signal $$x_T(t)$$ is a discrete sequence that is the sampling of $$X(f)$$ at rate $$F=\frac{1}{T}$$ in the frequency domain.

On the other hand, periodic $$x_T(t)$$ can be written in the form of Fourier Series that represents a periodic function as the sum of sine and cosine waves 

$$
\begin{equation}
    x_T(t) = \sum_{n=-\infty}^{\infty} c_{n}e^{ in \omega_{0} t}
    \label{eq:fs} \tag{7}
\end{equation}
$$

$$
\begin{equation}
    c_{n} = \frac{1}{T} X[n \omega_{0}]
    \label{eq:cn} \tag{8}
\end{equation}
$$

where $$c_{n}$$ is called Fourier Transform coefficient representing the height of the corresponding frequency component, $$\omega_{0} = 2 \pi f_{0}$$ and $$f_{0}$$ is the _fundamental frequency_  $$f_{0} = \frac{1}{T}$$.

Expressing periodic signals in the form of Fourier Series matters because complex exponentials are the eigenfunctions of the Linear Time-Invariant (LTI) system so they bring a lot of convenience for calculations. This is another whole concept to expand on but a bit off the scope of this post. Feel free to go down this rabbit hole by yourself if you’re interested.

# Discrete-Time Fourier Series
The title says it all. This time, we consider a periodic discrete-time signal (whereas previously it’s periodic continuous-time). We have a finite discrete function $$x[t]$$, and $$x_T[t]$$ is the periodic extension of $$x[t]$$ with period $$T$$.

<figure>
<img src="{{ "/assets/images/discreteperiodic.png" | absolute_url }}"
width="60%" hspace="1" align="left">
<figcaption>Fig.5 - Finite discrete signal (left) and periodic discrete signal (right). </figcaption>
</figure>

Again, we’re gonna see the problem from the sampling point of view. 

<figure>
<img src="{{ "/assets/images/dtfs.png" | absolute_url }}"
width="60%" hspace="1" align="left">
<figcaption>Fig.6 - Fourier Transform of periodic discrete signal and the relation with Fourier Transform of periodic continuous signal. </figcaption>
</figure>


$$x_T[t]$$ can be expressed as

<!-- $$x_T[t] = x(t) * 1/T ш(t/T) . Tш(Tt)$$ -->

$$
\begin{equation}
    x_T[t] = x(t) * \frac{1}{T}ш(\frac{t}{T}) . Tш(Tt)
    \label{eq:dtfs1} \tag{9}
\end{equation}
$$

Mapping into frequency domain (again, using the two mantras)    

$$
\begin{equation}
    \mathcal{F}\{x_T[t]\} = \mathcal{F}\{x(t)\} . \mathcal{F}\{\frac{1}{T}ш(\frac{t}{T})\} * \mathcal{F} \{Tш(Tt)\} \\
                          = X(f) . \frac{1}{F}ш(\frac{f}{F}) * Fш(Ff) \\
                          = X[f] * Fш(Ff)
    \label{eq:dtfs2} \tag{10}
\end{equation}
$$

Therefore, $$\mathcal{F}\{x_T[t]\}$$ is Fourier Transform of **_continuous periodic_** signal $$x_T(t)$$ **_duplicated infinite times_**. 

Likewise, $$x_T[t]$$ can also be written in the form of a Fourier Series


$$
\begin{equation}
    x_T[t] = \sum_{n=-\infty}^{\infty} c_{n}e^{ in \omega_{0} t}
    \label{eq:dtfs} \tag{11}
\end{equation}
$$

$$
\begin{equation}
    c_{n} = \frac{1}{T} X[n \omega_{0}]
    \label{eq:dtfs_cn} \tag{12}
\end{equation}
$$

# Conclusion
To summarize, in this post, we’ve started by defining what is Fourier Transform at a high level. It is followed by discussing how to use the lens of sampling to intuitively crack the code of some variants of Fourier Transform — Fourie Series (FS) and Discrete-Time Fourier Series (DTFS). Let's explore some other variants on the next one.

<!-------------------------------- FOOTER ----------------------------> 

[^fnote1]: not necessarily in time domain but let’s just simply assume the time-frequency duality here.
