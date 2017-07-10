### Code

I used to hate the word code. Obviously, I have grown to accept it, but I still find it irritating. Why? Because code is a series of instructions or procedures to follow. Code is an  obtuse message someone sends so that others can't read it. This does not describe what I spend most of my time on. Instead, I make processes.

### Process

This is my preferred term. Process implies motion and change. Conceptualizing process is something we do every day, when describing how to bake a cake or drive to Seattle. It generalizes to many different tasks, including mathematics, software abstractions, and algorithms development.

Lets see an example of process being really great.

So I am typing this sent_nce here. And y_u are f__l__g in t__ bl__ks. What are the blanks? If you can figure this out congrats. It takes me a minute.

Now code an automatic blank filler. How do you even start? Who knows, really.

Lets try again focusing on process. Clear your mind, and go back much and do it again much slower. Try to follow your own though process in figuring out the blanks. If you are having trouble doing it really slowly, try blocking part of the text as you read it, to force you to slow down.

What did you do to figure out the blanks? Did you find yourself guessing several different possible words? Did you try to see if the sentence made sense while considering that word? This is what I did, and what I will sort of run with, but if you did not think like this, then that is fine too.

Now, lets try to code this sort of thinking, focusing on each part in turn.

__Guessing words:__

Now, we as humans understand how to guess words, but how might a computer guess words? Probably in a similar way, right? A computer doesn't know English natively, so we need to give the computer a dictionary, because it has no idea what a word is. So here is our algorithm


1. Choose some word randomly from a dictionary.
2. If that word seems to match up with the outline of the sentence, then pick that word.
3. Do the first two steps as long as necessary before getting a word.

Now see how this gets translated into a real programming language, Python,

[code language="python"]
def guess(word_with_blanks,dictionary):
    '''
    word_with_blanks: a string with underscores for missing letters
    dictionary: a list of all viable English words
    '''
    for guess_word in dictionary:
        if matches(guess_word, word_with_blanks):
             return guess_word
[/code]

That translated nicely! We haven't told the computer what <code>matches</code> does though, and so this doesn't work yet.

[code language="python"]
def guess(word_with_blanks,dictionary):
    '''
    word_with_blanks: a string with underscores for missing letters
    dictionary: a list of all viable English words
    '''
    for guess_word in dictionary:
        if matches(guess_word, word_with_blanks):
             return guess_word
[/code]

If we want this to actually be random, instead of choose the first word, we need  only need a small change.

[code language="python"]
    def guess(word_with_blanks,dictionary):
        '''
        word_with_blanks: a string with underscores for missing letters
        dictionary: a list of all viable English words
        '''
        for i in range(10000):
            guess_word = random.choice(dictionary)
                if matches(guess_word, word_with_blanks):
                    return guess_word
[/code]

Are you curious how well this strategy actually works? If you are interested, I put some very simple, but working code [here](https://gist.github.com/weepingwillowben/6dd77d47c151dddda568cb132422ca95). You can run it by copying and pasting the code to [here](https://repl.it/languages/python3), or download it and run it on the command line.

If you run it, you will see that it does quite poorly. Only two of the words are guessed at all (you, the), and "the" is guessed incorrectly. Something unfortunate is going on. We could increase the size of the dictionary. But then there would be more words which could work, so this would decrease the chance that any of our guesses is incorrect.

#### Being wrong

So it looks like our idea for an algorithm was no good. In this state, it is not going to be useful in any circumstance. So what to do next? So what is it that allows us to know about the


#### The messiness of the real world


During my exploration of process, I have encountered many things like this and grown frustrated as I realize that no clean, beautiful solution can  possibly work super well. English words are invented all the time, they change in frequency, and you can't possibly store them, model them, or guess them from some static database. The problem itself is dynamic.

And in order to make something to solve a dynamic problem, you need data. But that is what the internet is for, right? The internet, with its messy protocols, network errors, slow download speeds, is our savior.

The real world is messy. Words
