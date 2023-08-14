# Samsara

Repository for all of the songs found in my Samsara album that use Sonic-Pi. This is very usually for rhythmic elements, but sometimes other stuff.

# Hacker Note
Some of these songs are too big to fit into a buffer. so you may need to make your only Sonic-Pi line of code just point to the file, something like this:  
`run_file "/Users/xlogicx/Documents/sonic/Binary Coded Decible/BinaryCodedDecible.rb"`

You'll notice that I use .rb extensions...best kept Sonic-Pi 'secret': it's all just ruby. You could even import ruby gems and use that crap in your songs. Want to circumvent consistent random where it sounds the same for everyone? sure, just import the time module and parse you some microseconds for the seed. We're hackers, don't give us artificial limits.
