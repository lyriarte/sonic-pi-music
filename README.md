# sonic-pi-music


Music, loops, samples made with [sonic-pi](https://sonic-pi.net/).


License: [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/)


## Directory contents

  * **loops**: Standalone live loops.
  * **live_kit**: Support for live coding. Managing chord progressions, support for USB keyboards, bank of keyboards, bass, drums patterns.
  * **live_sessions**: Sample live coding sessions, using the `live_kit/main_loops.rb` file to manage chord progressions.
  * **jazz_standards**: Standard chord progressions with usual jazz or latin keyboards, bass, drums patterns. Also need the `live_kit/main_loops.rb` file.
  * **bin**: Helper bash scripts for linux desktop. Run `cat /proc/asound/cards` in a shell to find available interfaces.


## Playing the music


### loops

Just load the file in a buffer and run the code.


### jazz standards

  1. load `live_kit/main_loops.rb` in a buffer, run.
  2. load one of the files from the `jazz_standards` folder in another buffer, run.
  3. in a third buffer, run `cue :start`


### live sessions 

  1. load `live_kit/main_loops.rb` in a buffer, run.
  2. load each file from one of the `live_sessions` subfolder in a buffer
  3. run the files in that order: `setup.rb`, `drum_n_bass.rb`, `sounds.rb`, `cues.rb`
