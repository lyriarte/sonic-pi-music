set :bpm, 80
set :beats, 2
set :sub_beat, 4

set :start_beats, true

chords_A = 
  [(chord :B, :minor)] * 2 + 
  [(chord :A, :major)] * 4 + 
  [(chord :Fs, :minor), (chord :G, :major)]


chords_B = 
  [(chord :D, :major)] * 2 +
  [(chord :A, :major)] * 2 +
  [(chord :E, :minor)] * 2 +
  [(chord :B, :minor), (chord :A, :major)]

set :chords, ( chords_A * 2 + chords_B * 2).ring
