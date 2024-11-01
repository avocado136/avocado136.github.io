---
header:
  overlay_image: /assets/images/rag.png
#   caption: "Photo credit: [**Marcus Spiske**](https://unsplash.com)"
permalink: /portfolio/rag_app/
date: 2024-11-02
toc: true
toc_label: "Contents"
---

# A Simple Chatbot to Practice Retrieval Augmented Generation

*(I made the code publicly available [on GitHub][1].)*

In recent years, the field of natural language processing (NLP) has seen tremendous advancements, with new techniques emerging to make AI models more powerful and efficient. One such innovation gaining widespread attention is Retrieval Augmented Generation (RAG). Unlike traditional language models, RAG combines pre-trained language generation with real-time document retrieval to produce responses based on external, often up-to-date, information. This makes it especially useful for answering queries related to specific documents not included in the model’s training data.

Curious to understand RAG in action, I decided to create a simple chatbot capable of retrieving and generating answers based on a specific document. This project, while basic in scope, was a hands-on exploration into how RAG can bridge the gap between static knowledge in model training and dynamic, document-specific knowledge. Through this, I aimed to build a foundational understanding of RAG principles and its practical applications in developing smarter chatbots.

# Some results
I tried to input the [Llama 2][2] paper into RAG and below are some or the queries and answers from the chatbot:

1. **Query 1**:

**Question**: What is novel in the paper Llama 2?

**Answer**: Based on the provided context, what appears to be novel in the paper Llama 2 is:
* The open release of Llama 2, a large language model, to encourage responsible AI innovation and draw upon the collective wisdom, diversity, and ingenuity of the community.
* The Responsible Use Guide provided, which offers guidelines for safe development and deployment of Llama 2, acknowledging potential risks and emphasizing the need for safety testing and tuning in specific applications. 
* The comparison of Llama 2-Chat models with ChatGPT generations, including a human evaluation without system prompts, which shows an increase in win rate for Llama 2-Chat.
* The competitiveness of the largest Llama 2-Chat model (70B) with ChatGPT, with a win rate of 36%. 
* The exceptional performance of Llama 2-Chat 34B, which achieves an overall win rate of over 75% against equivalently sized Vicuna-33B and Falcon 40B models.

These aspects may be considered novel contributions in the paper Llama 2.

2. **Query 2**:

**Question**: Can you explain the scaling trends that is mentioned in the paper Llama 2?

**Answer**: Based on the provided context, the paper Llama 2 discusses scaling trends in terms of data and model size for the reward model. The authors fine-tuned different model sizes on an increasing amount of the reward model data collected each week (see Table 26 for details on volume per batch). Figure 6 reports these trends, showing that:
* Larger models generally obtain higher performance for a similar volume of data. 
* The scaling performance has not yet plateaued given the existing volume of data.

This indicates that increasing the model size and data volume can lead to improved perfor- mance, but the study suggests that there is still room for further scaling.

3. **Query 3**:

**Question**: How did the authors evaluate the model?

**Answer**: Based on the provided context, the authors evaluated the model using a human- centric benchmark called Agieval, which involves presenting human annotators with prompts and generations from two models (Model A and Model B) side-by-side. The annotators were asked to rate which model is better (helpful while also being safe and honest) on a 7-point scale, with categories such as ”A is much better”, ”About the same”, ”B is slightly better”, and so on.

Additionally, the authors also used a test set of prompts for both helpfulness and safety, and asked three annotators to judge the quality of the answers based on a 7-point Likert scale (the higher the better). They observed that the reward models were well-calibrated with human preference, enabling them to use the reward as a point-wise metric. Furthermore, the authors validated major model versions with human evaluations, which involved comparing model responses and presenting them to GPT-4 in a randomized order to alleviate bias.

4. **Query 4**:

**Question**: What does it mean by Safety Data Scaling?

**Answer**: Based on the provided context, Safety Data Scaling refers to the process of adjusting the amount of safety training data used during the RLHF (Reinforcement Learning from Human Feedback) stage of training Large Language Models (LLMs).

Specifically, it involves gradually increasing the amount of safety data while keeping the helpfulness training data constant (0.9M samples). This allows the researchers to investigate how the addition of safety training data affects the model’s performance, particularly in terms of helpfulness.
In this context, Safety Data Scaling means modifying the proportion of safety data in the training dataset to evaluate its impact on the model’s behavior and output. The goal is to understand how more safety data can influence the model’s ability to respond safely to prompts, without compromising its helpfulness.

By scaling the safety data, the researchers aim to observe trends and patterns in the model’s behavior, such as:

1. Changes in the mean safety RM score as a function of increased safety data.

2. Shifts in the distribution of safety RM scores, including a reduction in the number of unsafe responses (left tail) as more safety data is added.

By analyzing these trends, the researchers hope to identify the optimal amount of safety data required to achieve a balance between helpfulness and safety in the model’s output.


<!------------------------------- FOOTER ------------------------------------->

[1]: https://github.com/huukim136/rag_app
[2]: https://arxiv.org/pdf/2307.09288
