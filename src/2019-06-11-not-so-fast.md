---
title: "Mind the Gap: Analyzing the Performance of WebAssembly vs. Native Code"
date: 2019-06-11
---

- USENIX Annual Technical Conference 2019
- [[1901.09056] Not So Fast: Analyzing the Performance of WebAssembly vs. Native Code](https://arxiv.org/abs/1901.09056)

The title says it all: the main point of the paper is that the claims made by
the paper introducing WebAssembly[^wasm-intro] are not as impressive as it
seems; the authors argue that the benchmarks used (PolyBenchC) are not
representative of typical WebAssembly use cases. It supports its claim by
porting and benchmarking with the SPEC CPU benchmark suite (BROWSIX-SPEC) to the
browser by developing an extension (BROWSIX-WASM) to BROWSIX, which exposes a
Unix-compatible interface in the browser.

[^wasm-intro]:
[Bringing the web up to speed with WebAssembly](https://dl.acm.org/citation.cfm?id=3062363)

> This evaluation confirms that WebAssembly does run faster than JavaScript (on
> average 1.3× faster across SPEC CPU). However, contrary to prior work, we find
> a substantial gap between Web- Assembly and native performance: code compiled
> to WebAssembly runs on average 1.55× slower in Chrome and 1.45× slower in
> Firefox than native code

### thoughts

> Each benchmark was executed five times. We report the average of all running
> times and the standard error.

I'm not exactly sure how benchmarking should be done in an academic context,
but I remember reading something about how using the average isn't always good.
Probably should investigate further.

![Benchmark results](./img/not-so-fast-fig3.png)

How is it possible that in some cases, WebAssembly actually **outperforms**
native code, especially since both are compiled with the same compiler (clang)
but with different backends? Is JIT **that** good?

The takeaway seems to be that WebAssembly isn't as fast as stated; but I don't
think this really matters in terms of real-world implications. As stated by the
authors themselves, WebAssembly still achieves a 1.3x mean speedup over asm.js
(matching the numbers reported in [^wasm-intro])
with negligible JIT-compile times (see Table 2).
