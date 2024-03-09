# Calculator APP For Engineering Students (CAFES)
I know what you're thinking...
"Gosh Aly, a calculator app?! What are we 11 years old???! At least be a little creative."

I get it, I get it... this is THE beginner computer science project. But this is no regular calculator app babes... nonono, this is *The* Calculator App TM.

## Why a Calculator?
It all comes down to what happened yesterday night, March 6th, 2024.
I (and I mean this with no exaggeration or hyperbole) got my ass **handed** to me writing the Intro. to Computer Engineering midterm. 
It was bad. 
And part of the reason it was so bad was because with such little time to do so many questions, it was entirely impossible to do the math AND keep track of units. 
So with my back to the wind, and my eyes staring into the sun, I ignored all the units and punched whatever numbers I saw directly into my calculator.
It was bad.

But really what alternatives did I have?
It took so long to do the calculations by hand on my physical calculator and notebook that I couldn't keep up!
And it would've taken even longer to do the whole thing in a python notebook or REPL because
1. You can't sketch diagrams in a python notebook
2. Type data is immediately lost the second you punch it in (meaning you have to check the units yourself anyways)
3. Matrices look so ugly it makes me want to kms
4. No subscripts and no convenient objects 😔. You end up with names like Hb_mu_s_eV.

I love python, I really do. And even more than that I love working in my terminal...
But I need something quick and easy that will house all of my calculations with no problems.

## What about <insert alternative here>
Desmos, MATLAB, Mathematica...
All of them are great. In fact, I love Desmos more than almost anything in the whole world. I love Desmos more than my own family. I almost love Desmos enough to not do this project. But it (and all other alternatives) fail to do what I want them to do: be *complete*.
I want a very specific set of features all contained within 1 program, is that too much to ask?

## Features I want (so, so bad)
- It needs to able to do arithmetic (obviousLY! 1+1, 3\*5, 14^2, all of those beautiful things)
- Also, quick variable creation (just type in n=5, nBr=16e-5 and you're set)
- Linear algebra is a MUST
- Automatic unit checking and conversions with a simple syntax
    - `myVar = 14 meters` or `mass = 72 kg`
- LaTeX rendering (subscripts, integrals, matrices, the whole shabang)
    - It should work like Desmos with little fuss
- Built in constants (I'm talking geometric constants like pi and e but also physics constants like boltzmann's constant, Avagadro's number, etc.)
    - I have lost enough of my life declaring these over and over again in my REPL
- JS-like object/namespace/dictionary creation to house object data
    - For example if I'm working with a bunch of semiconductors and the numbers that describe them I should be able to avoid polluting the namespace by saving each of their values to an object like so:
    `Hf.μ = 14 V`, `Pb.μ = 15*pi V`
- If it could also do analytical calculus (like solving integrals) I might even cry. Gosh even thinking about an app like this is making me salivate like a dog in heat.
    - For a demo, see https://www.integral-calculator.com

## But how babygirl?
-- a.k.a implementation & technologies --
Really, this is my favourite part of starting a project: picking the language.
I get so much happiness from it idk it's like the most entertaining thing in the world.
Every language has a colour:
- Rust is orange
- Swift is creme
- Python is green
- C++ is blue
I set them all up on the wheel and let it spin, so that the gods decide what is best for me.

Just kidding, as I was researching for this project I heard one of my favourite youtubers call Swift an "excellently designed language" so I had to check it out.
I've never used Swift before so, hopefully I'll have a working prototype done by 2028

Aly Ashour. March 7, 2024.
