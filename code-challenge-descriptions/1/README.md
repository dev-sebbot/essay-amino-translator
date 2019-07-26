# CASS code challenge 1
These are the requirements for CASS Code Challenge #1! The competition will run between July 8th -- August 8th.

## The challenge
Your task is to create a [quine](https://en.wikipedia.org/wiki/Quine_(computing)) that outputs 750,000 files that contain copies of its source code. A quine can't take any inputs through the console, an external file, or over the network -- all information to run the program must be contained within the source file.

You aren't allowed to use a "cheating" quine, as outlined in the wikipedia page.

## Judging
Your program will be judged on three criteria:

- Speed: the faster the program runs when clocked with the Unix utility `time`, the better
- Terseness: the fewer characters in the program's source code, the better
- Coolness: Each program will be put into an office-wide poll for how cool the solution is

Get your Judging Score as high as possible:
```
    time (milliseconds)
    size (number of characters per file)
    coolness (ranking relative to rest of office)
    
    judging_score = (coolness * 7000) - ((size * 300) + time)
```

## Requirements
A Github repo with installation instructions in the README.md FOR LINUX submitted to the `code-challenge` channel on Slack by August 8th.

## Reward
- kudos
- A $10 gift card to Qdoba or Jimmy John's or something smh

## Tips
- The more characters you have, the faster you can get your program to run
- The fewer characters you have, the shorter your program is
- If it isn't C/C++, your program is cooler, probably
- file i/o is weird
