---
title: "Rigorous Benchmarking in Reasonable Time"
date: 2019-06-12
---

- ACM SIGPLAN International Symposium on Memory Management
- [Rigorous benchmarking in reasonable time](https://dl.acm.org/citation.cfm?id=2464160)
- [Benchmarking correctly is hard (and techniques for doing it better) - Julia Evans](https://jvns.ca/blog/2016/07/23/rigorous-benchmarking-in-reasonable-time/)

While writing about the [Not So Fast paper](./2019-06-11-not-so-fast.html) I
became curious about benchmarking methodology; a quick search brought me to the
above blog post, then this paper.

In addition, this:

> Without wishing to pick on this work in particular, in 2019 statements like
> this depress me "Each benchmark uses 5 warm-up iterations"
> <https://ionutbalosin.com/2019/04/jvm-jit-compilers-benchmarks-report-19-04/> …
> -- Kalibera/Jones first showed this gives misleading results in 2012. I'd
> hoped that insight had percolated by now :(  
<https://twitter.com/laurencetratt/status/1117093954124701696>

Kalibera and Jones seem to be the leading experts on benchmarking methodology.

The main claim of the paper is that there is a lack of statistical rigor when
reporting performance evaluations via benchmarks. The paper goes on to offer
several recommendations on how to better measure performance (and its variance)
along with several formulas to calculate the number of iterations needed at each
level (compilation, binary execution, iterations of the benchmark, etc.) in
order to make the best use of time.

> We focus on execution time, the key measurement in, for example, 90 out of 122
> papers presented in 2011 at PLDI, ASPLOS and ISMM, or published in TOPLAS
> (nos. 1–4) and TACO (nos. 1–2). Unfortunately, the overwhelming majority of
> these papers reported results in ways that seem to make their work impossible
> to repeat, or did not convincingly demonstrate their claims for performance
> improvement: 71 failed to provide any measure of variation (such as variance
> or a confidence interval) for their results. This is unparalleled in most
> other scientific and social scientific fields. It risks reporting misleading
> results.

This is pretty sad. Are standards for research into computer science
worse than those for various social sciences?

### thoughts

Language VMs are interesting from a performance evaluation standpoint because
modern ones often do
[profiling](https://source.android.com/devices/tech/dalvik/jit-compiler) in
addition to [JIT](https://en.wikipedia.org/wiki/Tracing_just-in-time_compilation).
This means that the program performance will change over time as optimizations
kick in. Note that this is also the case for regular binaries but to a much
smaller extent due to paging, caches, etc. This is why the paper talks about
a steady state (i.e. a state where the performance no longer suddenly varies).

Discussion regarding benchmarking and statistics remind me of
[Programmers Need To Learn Statistics Or I Will Kill Them All – Zed A. Shaw](https://zedshaw.com/archive/programmers-need-to-learn-statistics-or-i-will-kill-them-all/).

The formulas derived were non-trivial[^non-trivial] to someone without a statistical
background; I really need to crack out the statistics textbooks and get a better
understanding of this stuff.

[^non-trivial]: read: impossible to understand

I remember reading something about using various information criteria being
preferred over significance testing and such, but I'm not sure what the
implications of each approach means.

This is embarassing. I wasn't able to follow the formulas in the paper; I'm
coming back and rereading this after learning a bit more statistics. This is a
must read for anybody who has to evaluate performance.

This paper should come in handy when reading about
[new benchmark frameworks](https://renaissance.dev/resources/docs/renaissance-suite.pdf).
