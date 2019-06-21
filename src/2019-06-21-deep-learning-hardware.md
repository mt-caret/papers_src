---
title: "Deep Learning Hardware: Past, Present, and Future"
date: 2019-06-21
---

- 2019 IEEE International Solid- State Circuits Conference - (ISSCC)
- [1.1 Deep Learning Hardware: Past, Present, and Future - IEEE Conference Publication](https://ieeexplore.ieee.org/document/8662396)

Not really a paper, but more like an opinion piece?

Talks about past (as in before nerual networks became wildly popular) attempts
at accelerating neural networks, analyzes the reasons behind its popularization
(improved methods, larger datasets, cheap compute in the form of GPGPU, open
source libraries), and predicts the future of hardware acceleration of deep
learning based on current trends.

### thoughts

- Neural Networks on Graphs
- Graph Embedding Networks
- Memory-Augmented Networks
- Complex Inference and Search
- Sparse Activations

These are all things I'm not that familiar with, and the author claims that
these elements will shape the architecture of future DL systems, therefore
hardware. Should look into references and research. Saving power by utilizing
sparse activations sounds cool.

The usual talk about how supervised learning, reinforcement learning is
inefficient in terms of extracting information from data, and about how
"self-supervised learning" is the future. I remember hearing something similar
from the author in a [talk from several years ago](https://www.youtube.com/watch?v=IbjF5VjniVE)
([here](https://blog.piekniewski.info/2016/11/21/yann-lecun-cmu-11-2016-comments/)'s
a quick summary)

> However, chances are that the bulk of the computation in future DL systems
> will still consist primarily of convolutions.

OH
