---
title: "Malfunctional Programming"
date: 2019-06-19
---
- ML 2016 with ICFP 2016
- [Malfunctional Programming](https://www.cl.cam.ac.uk/~sd601/papers/malfunction.pdf)

This paper proposes Malfunction, an untyped intermediate language representation
(based on OCaml's IR[^ocaml-ir]) intended to be a target for functional
programming language compilers.

The motivation for Malfunction is as follows: if you want to build a functional
programming language, there are several approaches to get something executing.

One approach is to target C or make use of compiler frameworks like LLVM. This
will probably produce fairly optimized code, but leaves the difficult task of
creating a runtime (including garbage collection) up to you.

Another approach might be to target bytecode for .NET CLR or JVM. This has the
benefit of a mature, performant runtime at the cost of being restricted to the
runtime's design choices (such as the particular type system used) making it
difficult to take advantage of more sophisticated type systems.

Compiling to dynamic languages such as JavaScript also is an option, but if your
language already is statically typed, runtime type checks are redundant.

Malfunction strikes a nice middle ground among the approaches as a) it is
untyped and assumed correct, so does not restrict the language's type system
nor does it duplicate type checking work at runtime, and b) benefits from
OCaml's mature runtime and backend optimizations.

[^ocaml-ir]: `-dlambda` output

A simple program taken from the
[repository](https://github.com/stedolan/malfunction/blob/master/docs/print_args.mlf):

```
; This program prints its command-line arguments to stdout
(module

  ($argv (global $Sys $argv))

  ; $argv is a vector, turn it into a list
  ; lists are either the integer 0 (nil) or a block of tag 0 (cons)
  ($argc (length $argv))
  (rec
    ($argv_to_list (lambda ($i)
      (if (== $i $argc)
        0
        (block (tag 0) (load $argv $i)
          (apply $argv_to_list (+ $i 1)))))))
  ($argv_list (apply $argv_to_list 1)) ; Start at 1 to skip argv[0]

  ; Since this is the standard OCaml list representation, we may
  ; use standard library functions

  ($print (lambda ($s)
    (apply (global $Stdlib $print_endline) $s)))
  (_ (apply (global $List $iter) $print $argv_list))

(export))
```


### thoughts

> The next question is whether it’s at all valid to reuse Lambda, which was
> designed solely as an intermediate representation for OCaml. ... I conjecture
> that OCaml will not miscompile any Malfunction program, or at least that when
> it does, it will also miscompile a sufficiently contrived OCaml program.

I expected rigorous analysis rather than conjecture, but I guess Malfunction is
more of a cool (and fairly useful) hack than something that warrants formal proofs?

I've been looking for something like this for quite a while[^core], I'll
probably make use of this when I build my own functional programming language.
Being able to interface with OCaml is a nice bonus as well.

[^core]: [Haskell's Core](https://www.youtube.com/watch?v=uR_VzYxvbxg) would
have been a good candidate if only it wasn't lazy...

One thing I noticed while reading the [spec](https://github.com/stedolan/malfunction/blob/master/docs/spec.md)
was the absence of refs. I guess they aren't implemented yet?

### related resources

- [The Compiler Frontend: Parsing and Type Checking - Real World OCaml](https://dev.realworldocaml.org/compiler-frontend.html)
