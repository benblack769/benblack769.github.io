# A Sequential Learning notation for Deep Nueral Archctectures


Most publications and explanations of deep learning have two sorts of explanation types:

1. Math that looks like this :
2. Diagrams that look like this: ![colah-image](/images/deep_learning_basics/LSTM3-chain.png)

While I must give all credit to Colah's blog for putting together that excelent diagram, I think it is telling why it is so well known: every other LSTM diagram before that was kind of terrible. Making high quality diagrams is hard, and takes a lot of time and effort. 

And it is hard to do math in diagrams---explaining each step will take a lot of time and effort, as each transformation will require a new diagram. So proof-oriented diagrams (like my own here: ![backprop diagrams](/posts/blog/backprop_in_4_diagrams.md) are extremely time consuming, so you more often see proof written like this:

TERRIBLE LOOKING PROOF HERE


What I am looking for is a notation system that is 

1. Formal enough to write proofs in
2. Expressive enough to write most deep learning archtectures in
3. Easily written on a chalkboard, preferably possible to write on a keyboard


I'll start by example:


### Multi Layer Perceptron

To train on observations X and known values y on a 2 layer network via a MSE error

```
X --[M_1|relu]-> h_1 --[M_2]-> p => y
```

To train on discrete labels y with a softmax cross entropy error (a bit suprising, but yes, the [math checks out](https://deepnotes.io/softmax-crossentropy#derivative-of-cross-entropy-loss-with-softmax))

```
X --[M_1|relu]-> h_1 --[M_2|softmax]-> p => one_hot(y)
```

### RNN

To train on observation sequence `X_t` and label sequence `y_t` using MSE loss,

```
0 -> h_0
X_t|h_{t-1} --[Enc]-> h_t --[Gen]-> p => y_t
```

Of course, different functions can be specified for `Enc` and `Gen`:

#### Naive Feed Forward


```
0 -> h_0
X_t|h_{t-1} --[M_1]-> h_t --[M_2]-> p => y_t
```

Here Enc can be defined:



#### GRU

A somewhat computational definition:

```
0 -> h_0
h_{t-1}|x_t -> c_t
c_t --[R|sigmoid]-> r_t
c_t --[Z|sigmoid]-> z_t
x_t|(h_{t-1}*r_t) --[H|tanh]-> l_t
h_{t-1} * (1 - z_t) + l_t -> h_t
```

We can define a new macro instead, which will be useful if we want a layered GRU.


```
Enc: h_{t-1},x_t    
    h_{t-1}|x_t -> c_t
    c_t --[R|sigmoid]-> r_t
    c_t --[Z|sigmoid]-> z_t
    x_t|(h_{t-1}*r_t) --[H|tanh]-> l_t
    h_{t-1} * (1 - z_t) + l_t -> h_t
    return h_t
h_0 := 0
h_{t-1},x_t --[Enc]-> h_t
```

#### LSTM

```
0 -> c_0
0 -> h_0
h_{t-1}|x_t -> p_t
p_t --[F|sigmoid]-> f_t
p_t --[I|sigmoid]-> i_t
p_t --[C|tanh]-> l_t
o_t --[O|sigmoid]-> o_t
c_{t-1}*f_t + i_t*l_t -> c_t
tanh(c_t)*o_t -> h_t 
```

### Deep RL

To define an environment, we need a few custom functions:

* `reset() -> S_0`
* `step(S_{t-1}) -> S_t,O_t,r_t,d_t`

(in general, of course, these will not be differentiable)

#### Basic TD learning

```
0.999 -> gamma
reset() -> S_0
S_{t-1},a_{t-1} --[step]-> S_t,O_t,r_t,d_t
O_t --[Value]-> V_t => V_{t-1} * gamma + r_t
```

#### A2C with sepearate value and policy networks

```
reset() -> S_0
S_{t-1} --[step]-> S_t,O_t,r_t,d_t
V_{t-1} * 
```


## Low level syntax

Three primitive concepts:

* states
* parameters
* functions
* transforms

### States

States are local variable definitions. States are immutable and local to a single input value(possibly shared across time). State definitions have attributes

* Name
* Context (usually time)

A reference to a state is accesed with the notation: `<Name>_<context>` (with the context being optional, by default given context 0.

### Parameters

Parameters are global variable definitions that are shared across all data points and all contexts. Parameter instantiations are mutable, and by definition, they have the following attributes:

* Name 
* Shape (will be assigned a default shape, some langauge features will be avaliable without the shape being fully defined.


### Functions

Functions operate on states and update parameters. 

3 rules define a function:

* Forward: (In, Params) -> Out
* Autodiff: (In, Out, Params) -> ^In
* Update: (In, Out, Params) -> ^Params

If f is a stateless function (like relu) then Update() will accept and return an empty set of parameters. If f is a non-differentiable function (like one-hot) then Autodiff will additionally return constant zeros for its inputs.

Builtin functions include:

* dense(x)
* conv(x) 
* add(x,y) 
* exp(x)
* batch\_norm(x)
* dropout(x)

### Transforms

Transforms operate on functions (essentially higher order functions). Transforms have 3 major operations

* ForwardTransform: (InForwards,) -> OutForward
* AutodiffTransform: (Autodiffs,) -> Autodiff
* UpdateTransform: (Updates,) -> Update

Some special transform include:

* compose (Chains outputs of function a to inputs of function b, composes updates and autodiff)
* nograd (makes AutoDiff return 0s)
* adam\_opt (Adds new parameters, changes UpdateTransform via adam rule)
 

### Syntax transformation rules






















