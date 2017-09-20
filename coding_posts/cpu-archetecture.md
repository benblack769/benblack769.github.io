# Instruction level parallelism: An introduction to computer architecture

## Purpose

* Convince you that software developers should care about architecture
* Show you how to exploring how code runs on hardware
    * Highly advanced technology. In physics or chemistry, the most advanced technology is very expensive, only available in hard to access certain labs. In computer architecture, the most advanced technology is on your laptops.
* Show you some really fun stuff

## Why instruction level parallelism?

Basic circuits are inherently sequential: one transistors needs to switch before the next one can, and that switch is a physical change that takes time.

![clock-speed](/images/cpu-archetecture/transitor-diagram.png)

You can make the transistors change faster by increasing voltages. Unfortunately, using this technique there is a rather unfortunate physical property where $$\text{Power} = \text{Clock speed}^2$$, so quite quickly, your silicon chip will simply melt if you increase the voltage to increase clock speed.

What this means in practice is that there is a limit to how much you can increase speed by increasing voltage. In fact, that point was reached a long time ago.

![clock-speed](/images/cpu-archetecture/clock_speed.png)

Meanwhile, More's law continues:

![clock-speed](/images/cpu-archetecture/Transistor-Count-over-time.png)

So how can we use those extra transistors?

Here is an idea: instead of trying to use 1 circuit faster, lets try to use a bunch of circuits at the same time. In other words, lets try running our computations in parallel.

## What is parallelism?

Before running a computation, you often need other computations to be run first.

From a hardware perspective, you can view this as circuit depth. From a software perspective, you can see this as data dependency chain.

Here is some silly example code

    a = 3
    b = 1
    d = a + b
    c = a - b
    x = 1
    r = d * x

Here is a dependency graph of the code

![basic-dependencies](/images/cpu-archetecture/basic-data-dependencies.png)

You can also do this for arbitrarily long code. The idea of "reductions" (as in the MapReduce paradigm) is based on this.

    sum = 0
    sum += a[0]
    sum += a[1]
    sum += a[2]
    sum += a[3]
    sum += a[4]

![sum dependencies](/images/cpu-archetecture/sum-data-dependencies.png)

This has a circuit depth of 4. How can you lower that depth?

Well, addition is associative, so what if we start adding from the other direction as well?

![sum reduce dependencies](/images/cpu-archetecture/sum-reduce-data-dependencies.png)

This has a depth of 3, so we made it faster. You can generalize this process to *n* associative operations, resulting in depth of log(*n*).

Hopefully you can believe that this is a general and powerful method of identifying parallelism. In fact, we are very close to an idea of optimal parallelism.

So now that we know what to look for when trying to parallelize things, lets go back to the hardware.


## Brief introduction to assembly

Hardware is essentially an interpreter. Conceptually, it reads the code 1 line at a time, and processes it, and moves on to the next line.

So, as you might expect, the way computers look at code is as a sequence of commands. The syntax reflects this concept.

As I also want some real world examples, I will introduce you to the basics surrounding x86 assembly, which is ubiquitous in desktop and laptop CPUs. Not of any fondness of the language, but because you can actually execute it on your machine.

x86 in GAS (GNU Assembly syntax) looks more or less like the following:

    <command> <src> <dest>

The src and dest can either be registers, or references to memory specified by registers. You can think of registers as a hardware form of local variables.

    `%rax` is a register.
    `(%rax)` is a reference to a memory location specified by `%rax`. This is equivalent to `*(ptr)` in C.  
    `4(%rax)` is an offset of 4 bytes from the pointer, equivalent to `*(4+char_ptr)` in C.

There are a set of common commands you will always see:

    add/sub/mul:    basic arithmetic
    lea:            pointer arithmetic
    sar/sal:        bit shifting (pos/neg powers of two)
    cmp/test:       ordinary and logical and based comparison.
    je/jne/jle <LOCATION>:  If the comparison is equal/not equal/less than or
                equal, "jump" to LOCATION (next instruction will be executed there)

Floating point arithmetic is a little different. The registers are called `xmm0` for 128 bit registers, and `ymm0` for 256 bit registers (yes, the first 128 bits of `ymm0` are exactly `xmm0`). The idea is that each float in them is only 32 or 64 bits, but there can be several in a single register. You can also do computations on lots of integers in them, but that is less common.

Basic command format is

    <cmd><p/s packed/single><s/d single/double>

Packed means you move the whole vector, single means you move the first element.

The `float` type in C is 32 bits, the `double` type is 64 bits.

Some examples

    movps 16(%rcx), %xmm0 //move packed
    addss %xmm0, %xmm1
    movss %xmm0, 16(%rcx)


There is also some archaic floating point arithmetic which is horribly slow, but it can work on 80 bit floats. If you ever see anything like Check ou

### References

Scraped from official docs: http://www.felixcloutier.com/x86/

Oracle docs. Fairly well organized. https://docs.oracle.com/cd/E18752_01/html/817-5477/ennbz.html

Official intel docs, many pdf volumes: https://software.intel.com/en-us/articles/intel-sdm

### x86 Example

How do you get assembly? One way is

    gcc -S <file>

You can also plug in your code [at this cool website](https://godbolt.org/) which outputs assembly.

Here is some very simple c++ code that multiplies a scalar by a vector of doubles.

{% highlight c++ %}
{% include sources/cpu-archetecture/pipelined_floats.cpp%}
{% endhighlight %}

Here is the generated assembly.

<code>
{% include sources/cpu-archetecture/pipelined_floats_clean.s%}
</code>

Lets go through this quickly. Because we are only concerned about performance, we can ignore large parts of it.

This is mostly crap that deals with how functions are called. The first few commands of any function will probably involve stuff like this, moving things to or from memory, and subtracting pointers.

    movq	(%rcx), %rax 	//load argument 1
    movq	8(%rcx), %rdx	//load argument 2

A early exit condition. Basically, this is a trick to get it to exit faster if the function isn't actually doing any work. It can also can make the inner loop faster. You can usually spot these things because they always involves some conditional branch, and often lots of shifting and subtraction.

    subq	%rax, %rdx		//???
    sarq	$3, %rdx   //rdx /= 8
    testl	%edx, %edx //%edx == 0
    jle	.L5            //if the above condition is true, return

Setting up the pointers in the inner loop so that there is less arithmetic that needs to happen to access arrays. This is fairly critical in fast code, there is some reason for concern if you don't see something similar to this before your loops. You can spot this from the `lea` command, and also that it is operating on pointers that are changed in the main loop.

    subl	$1, %edx
    leaq	8(%rax,%rdx,8), %rdx


One thing to note is that all of the above code can run crazily fast. It will usually not make a noticable differnece in code performance.

This next part is the important part, and the part that can be slow: our inner loop.

    .L4:
    	movsd	(%rax), %xmm0   
    	addq	$8, %rax
    	mulsd	%xmm1, %xmm0
    	movsd	%xmm0, -8(%rax)
    	cmpq	%rdx, %rax
    	jne	.L4

## Crash course in compiler optimization

For most purposes, people just treat assembly generation as a black box. You simply give gcc the `-O2` or `-O3` option, and trust that it makes your code faster. Unfortunately, for our purposes, we cannot treat the compiler optimizations as a black box. Compilers really are amazing, yet they are not yet perfect. Understanding how to guess, observe, and measure the level to which they are not perfect is key to understanding how your code executes on hardware.

### How your compiler sees code

To understand our compiler, we need to get inside its head. How does it see code, how does it work with it?


### Types of parallelism

* “Invisible” Parallelism
    * Instruction pipeline
    * Superscalar dispatch
    * Vector instructions
* Visible parallelism
    * Multi-core CPUs (threads)
    * GPGPUs?

I will go through these one by one, explaining how they work.

## "Invisible" Parallelism

When computer architects started realizing they had more transistors than they could use in sequential instruction, they knew that the code would have to be run in some kind of parallel manner.

They also knew that software developers are lazy and don't want to change their code.

The solution is to take code which the software developer thought was completely sequential, but actually execute some of it in parallel.

The following will be a touch on some of the techniques the computer architects and compilers came up with to run sequential code in parallel.

### Assembly

To explain the concepts fully, I have to bring in assembly code. However, I will translate the x86 back into a c like psedo-assembly, that is hopefully more accessible.

### Code dependency graphs

In code, there are obvious dependencies on previous code executing. For example,

```
    a += b
    a *= c
```

Clearly, the second operation depends on the first completing.

However, that is not always the case. For example,

```
    a += b
    d *= c
```

The entire idea of invisible parallelism is exploiting this idea.

### Instruction pipeline

The idea is to break up a single instruction broken up into multiple parts.

Each part executes in parallel with a different part of a previous instruction. Here is a diagram I pulled from the [Wikipedia page on this subject](https://simple.wikipedia.org/wiki/Instruction_pipelining).

![pipeline](/images/cpu-archetecture/Pipeline_4_stage.png)

I will not use this particular pipeline as an example. Rather, I will use floating point pipeline as an example, as it is easier to demonstrate and more sensitive to software.

The idea is that there are many steps to executing a floating point number. The hardware designer can separate out these steps on the hardware, and leave locations to separate out intermediate data, then you can use every.

Here is a diagram from a really old presentation that shows this concept at a high level [link](http://meseec.ce.rit.edu/eecc551-fall2002/551-9-12-2002.pdf).

![float pipeline](/images/cpu-archetecture/Floatingpointpipe.PNG)

Here is some very simple c++ code that multiplies a scalar by a vector of doubles.

{% highlight c++ linenos %}
{% include sources/cpu-archetecture/pipelined_floats.cpp%}
{% endhighlight %}

But this tells me very little on how it is actually executing on the machine. In order to learn more about that, I want to see the how the computer sees that code. It turns out that I am looking for the assembly code that the c++ code compiles to.

Luckily, gcc allows us to do this easily with a simple command:

    g++ -S <file>

I want efficient code, so I ran it with

    g++ -S -O2 <file>

You can try this out by going to [this cool website](https://godbolt.org/) (you might also want to click the "Intel" button to change the syntax to the same form that I am using here).

Here is a screenshot of this website:
![website screenshot](/images/cpu-archetecture/x86-website.PNG)

The generated assembly code is kind of messy, so I cleaned it up a little.

The important part is just the inner loop, which the online tool highlights.

    mulsd	(%rax), %xmm1, %xmm0
    addq	$8, %rax
    movsd	%xmm0, -8(%rax)
    cmpq	%rdx, %rax
    jne	.L4

Now, this is how it looks to the machine. In order to get an evidence for how this is actually runs, though, we will need to actually run it, and measure how fast it runs.

In order to do that we need a little boilerplate code to run it a whole bunch of times.

{% highlight c++ linenos %}
{% include sources/cpu-archetecture/pipelined_floats_exec.cpp%}
{% endhighlight %}

The only important thing to note about this code is that it runs the 6 instructions of the inner loop described above 1,000*1,000,000 times, or 1 billion times.

Now, how long should we expect this to take?

My computer runs at around 3ghz. According to intel's documentation [here](https://software.intel.com/sites/landingpage/IntrinsicsGuide/), `mulsd` takes 3 cycles, and the rest of them take 1 cycle. So if this was executing sequentially, then it would take 7 billion cycles, which should take at least 2 seconds.

Timing the compiled code with -O2 using the unix `time` command, this actually takes a shocking 0.45s.

This means it is running more than 4 times faster than you might expect.



Here is an example in x86:

    addq %rax,%rbx  // a += b

How does the pipeline interpret this?

    LOAD (%rpi) //load the next instruction: "addq %rax,%rbx" from memory
    DECODE // figures out if memory is





a
