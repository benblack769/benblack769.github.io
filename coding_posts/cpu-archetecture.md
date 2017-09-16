# Using C to accelerate code

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

My computer runs at around 3ghz.





Here is an example in x86:

    addq %rax,%rbx  // a += b

How does the pipeline interpret this?

    LOAD (%rpi) //load the next instruction: "addq %rax,%rbx" from memory
    DECODE // figures out if memory is





a
