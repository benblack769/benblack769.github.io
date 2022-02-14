---
title: "Accelerating CAS-Offinder"
slug: cas-offinder
under_construction: false
excerpt: "Accelerating an open source genome fuzzy search tool."
comments: false
share: false
img: /images/cas-offinder/data_pipeline.png
post_date: "2022"
---


[CAS-Offinder](https://github.com/snugel/cas-offinder) is a genomic search tool developed by the Genome Engineering Laboratory at Seoul National University. This tool has few users, but a flexible interface and a fast GPU accelerated implementation that makes it quite attractive. I decided that this tool could be even more useful if it was many times faster...

Over the course of this effort, I:

* Improved the core data representation to an efficient bit-packed format (allowing trillions of comparisons per second on a GPU)
* Simplified the algorithm (inner loop is ~20 lines of code, no local memory or hardware specific features used)
* Improved the multigpu support with multithreading (providing linear speedups on large datasets)
* Decreased memory consumption with data pipelining (total memory utilitzation on both CPU and GPU is now consistently under 500MB)
* Added signficiant unit testing for all key logical modules (improving confidence in the accuracy of the implementation)

The final implemention is in my fork of the project [here](https://github.com/benblack769/cas-offinder).

## The tool

### The use case

CAS-Offinder is primarily designed to find off-target sites for CRISPR gene editing technologies. When using this technology, treatment developers choose 1) a protein system and 2) A guide RNA sequence. If the protein and the guide sequence approximately matches the DNA strand in the genome, then the DNA will be cut. 

Through its flexible interface, CAS-Offinder can perform searches to find possible cut points for a wide variety of these protein systems.


### Genetic search complexities 

A genome is a series of nucleotides: A,C,T, or G. So 4 possiblities.

We can see where the string "ATCGC" appears in the genome with a simple string search. The complexity arises with 3 problems

#### Complexity 1: Symmetric DNA

DNA (unlike RNA) is composed of base-pairs. I.e, it looks like this

```
3-CAGTA-5
5-GTCAT-3
```

3 and 5 represent the direction of the nucleotide. However, note that both sides have a 3 end and a 5 end, and so while the system is read from the 5' end to the 3' end, it is still symmetrical, i.e. the above sequence and the one below are physically identical

```
3-TACTG-5
5-ATGAC-3
```

So we must search both possible representations, as both versions are of equal biological significance.

#### Complexity 2: Unequal nucleotide treatment


Now, not all nucleotides are created equally, sometimes two nucleotides are accepted by protein systems, while the others are rejected. To capture this notion of similar treatment, we should be able to specify combinations of nucleotides which are allowed. The interface allows this to be specified easily through mixed-base pairs. So the letter "R" means that it could be A or G. The letter "N" means it could be any nucleotide.


|   A   |    C   |   G   |   T   |
|:-----:|:------:|:-----:|:-----:|
|Adenine|Cytosine|Guanine|Thymine|

|   R  |   Y  |   S  |   W  |   K  |   M  |
|:----:|:----:|:----:|:----:|:----:|:----:|
|A or G|C or T|G or C|A or T|G or T|A or C|

|     B     |     D     |     H     |     V     |   N    |
|:---------:|:---------:|:---------:|:---------:|:------:|
|C or G or T|A or G or T|A or C or T|A or C or G|any base|

#### Complexity 3: Fuzziness

Now, genetic systems are highly random, taking place in a complex environment afflicted by kinetic, electrical and even quantum forces by surrounding molecules.

To take into account this final bit of randomness, we should allow some number of mismatches, so that we don't miss any possible cut sites.


## The algorithm

The original cas-offinder tool simply did a search comparing literal charachters. The following is the inner loop:

```
for (j=0; j<patternlen; j++) {
    k = l_comp_index[j];
    if ( (l_comp[k] == 'R' && (chr[loci[i]+k] == 'C' || chr[loci[i]+k] == 'T')) ||
            (l_comp[k] == 'Y' && (chr[loci[i]+k] == 'A' || chr[loci[i]+k] == 'G')) ||
            (l_comp[k] == 'K' && (chr[loci[i]+k] == 'A' || chr[loci[i]+k] == 'C')) ||
            (l_comp[k] == 'M' && (chr[loci[i]+k] == 'G' || chr[loci[i]+k] == 'T')) ||
            (l_comp[k] == 'W' && (chr[loci[i]+k] == 'C' || chr[loci[i]+k] == 'G')) ||
            (l_comp[k] == 'S' && (chr[loci[i]+k] == 'A' || chr[loci[i]+k] == 'T')) ||
            (l_comp[k] == 'H' && (chr[loci[i]+k] == 'G')) ||
            (l_comp[k] == 'B' && (chr[loci[i]+k] == 'A')) ||
            (l_comp[k] == 'V' && (chr[loci[i]+k] == 'T')) ||
            (l_comp[k] == 'D' && (chr[loci[i]+k] == 'C')) ||
            (l_comp[k] == 'A' && (chr[loci[i]+k] != 'A')) ||
            (l_comp[k] == 'G' && (chr[loci[i]+k] != 'G')) ||
            (l_comp[k] == 'C' && (chr[loci[i]+k] != 'C')) ||
            (l_comp[k] == 'T' && (chr[loci[i]+k] != 'T'))) {
        lmm_count++;
        if (lmm_count > threshold)
            break;
    }
}
```

While the compiler will likely optimize a complex condition like this into something reasonably efficient, and it is honestly a totally reasonable approach, we can do much better by rethinking the data structure. 

### A bitpacked data structure

Consider the following binary data encoding of a genome


T|C|A|G
---|---|---|---
0001|0010|0100|1000

I.e. a bit in a particular location signifies the presence or absence of a nucleotide.

Now, we can encode the mixed base pairs by simply computing the bitwise "or" of the nucleotides. For example

R|B|N
---|---|---
1100|1011|1111

Now, since each nucleotide only takes 4 bits, we can pack 8 nucleotides into a 32 bit word.

```
ATCGGTAC
=
0100,0001,0010,1000,1000,0001,0100,0010
```

And we can also pack 8 mixed base pairs into a 32 bit word

```
CTCGGNRG
=
0010,0001,0010,1000,1000,1111,1100,1000
```

Now, we can check how many mismatches this part of the genome has by simply computing a bitwise "and" (in C, this is the "&" operator).

```
0100,0001,0010,1000,1000,0001,0100,0010
&
0100,0001,0010,1000,1000,1111,1100,1000
=
0000,0001,0010,1000,1000,0001,0100,0000
```

And finally a "popcount" operation which checks the number of set bits.

```
popcount(0000,0001,0010,1000,1000,0001,0100,0000)
= 
6
```

So we know that 6 off the nucleotides matched, out of a possible 8, so there are 2 mismatches.

To check every possible position in the genome, not just the 8 nucleotide boundaries, some bit-shifting is needed. However, the full inner loop remains quite simple. The following code describes the inner loop.

```
size_t blocks_avail = 8;
for (size_t k = 0; k < blocks_avail; k++) {
    uint32_t mismatches = 0;
    for (size_t l = 0; l < blocks_per_pattern; l++) {
        uint32_t genome_block = (genome[genome_idx + l] >> (k * 4)) | (genome[genome_idx + l + 1] << ((blocks_avail - k) * 4));
        mismatches += popcount(
            genome_block & pattern_blocks[pattern_block_idx * blocks_per_pattern + l]);
    }
    if (mismatches <= max_mismatches) {
        // log result
    }
}
```

From a performance standpoint, this has several advantages from the original implementation:

1. The memory access pattern is local, regular, and easily cachable
2. There are no unpredictable branches anywhere
3. Several comparisons happen in parallel
4. popcount is hardware accelerated on almost all modern hardware platforms, and is very fast.
 

The complete, highly optimized inner loop is still extremely simple:

```
block_ty shifted_blocks[blocks_per_pattern + 1];
for (size_t i = 0; i < blocks_per_pattern + 1; i++) {
    shifted_blocks[i] = genome[genome_idx + i];
}
for (size_t k = 0; k < blocks_avail; k++) {
    uint32_t count = 0;
    for (size_t l = 0; l < blocks_per_pattern; l++) {
        block_ty cur = shifted_blocks[l];
        count += popcount(
            cur & pattern_blocks[pattern_block_idx * blocks_per_pattern + l]);
    }
    for (size_t l = 0; l < blocks_per_pattern; l++) {
        shifted_blocks[l] =
            (shifted_blocks[l] >> 4) |
            (shifted_blocks[l + 1] << ((blocks_avail - 1) * 4));
    }
    shifted_blocks[blocks_per_pattern] >>= 4;
    int mismatches = max_matches - count;
    if (mismatches <= max_mismatches) {
        int next_idx = atomic_inc(entrycount);
        match next_item = {
            .loc = genome_idx * blocks_avail + k,
            .pattern_idx = pattern_block_idx,
            .mismatches = mismatches,
        };
        match_buffer[next_idx] = next_item;
    }
}
```

The reason this is so incredibly efficient is that the `blocks_per_pattern` is typically small (<5) and is known at startup time when OpenCL is compiled, so the inner loop can be fully unrolled, and the `shifted_blocks` array can be replaced by a series of registers.

With this near-optimal hardware setup, we are able to achive truely incredibe comparison throughputs:

On a test input file with 91 nucleotides, 50 patterns, and on the human genome with ~3.2 billion base pairs, (and it is symmetric), that is `91*50*3.2*2=29000` billion comparisons.

On this test input, we got the following performance on various hardware platforms:

Hardware | time | Comparisons (billion/s)
--- | --- | ---
Dual RTX-2060 GPUs | 5.9545s | 4984 b/s
Intel(R) UHD Graphics 620 (on laptop) | 141s | 205 b/s   
12-core, 24 thread 1920x Ryzen threadripper CPU | 350.145s | 83.2 b/s

Note that on this input set, the performance is 10x or greater than the original cas-offinder tool all tested hardware platforms.

### Whole program optimization

The inner loop is not the only performance consideration. We also need to spend as much time in the inner loop as possible, and keep system resources under control.

#### Performance goals

In order to maximize GPU performance, we should make sure that all GPUs are operating all of the time:

1. If possile, file parsing and data preprocessing should not impede core compute proceedure.
2. Multiple GPUs should execute concurrently and independently to maximize compute efficiency.
3. Postprocessing and file/pipe buffering should not impeed GPU execution.

In order to keep memory utilization predictable:

1. Data that cannot be processed for a long time should not be read from disk.

#### Pipeline design

To solve all of the above goals, a data pipeline is created. This data pipeline has independent threads for input, output, and each compute device (represented by ovals) and communicate via two buffered channels, one for data input and one for output (represented by boxes).

![data pipeline](/images/cas-offinder/data_pipeline.png)

With this simple archtecture, all the performance goals are satisfied. 

1. File processing happens asynchronously, not impeeding computation
2. Each GPU is controlled via its own thread, operating independently.
3. Postprocessing file writing operates asynchronously
4. Data is not read if the input channel's buffer is full, minimizing memory consumption.

### Unit testing

Under the `test` directory are a number of unit tests, orchestrated through a custom (but effective) test framework.

These tests check many edge cases in conversions to and from the 4bit data format, file parsing, searching, and more.

These tests made optimizing certain proceedures (file parsing, searching, format conversions) extremely easy and fast---most of the optimiztions were implemented in a single day.

