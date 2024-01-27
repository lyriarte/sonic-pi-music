#  tongue drum ambient 100 bpm setup

set :bpm, 100
set :beats, 4
set :sub_beat, 4

set :phases, [
[
  (chord :B, :minor7),  (chord :B, :minor7),
  (chord :B, :minor7),  (chord :B, :minor7),
  (chord :E, :minor7),  (chord :E, :minor7),
  (chord :Fs, :minor7),  (chord :Fs, :minor7),
].ring, 
[
  (chord :G, :maj),  (chord :A, :dom7),  
  (chord :B, :minor7),  (chord :A, :dom7), 

  (chord :G, :maj),  (chord :A, :dom7),  
  (chord :Fs, :minor7),  (chord :Fs, :minor7),
].ring, 
[
  (chord :Fs, :minor7),  (chord :Fs, :minor7),
  (chord :Fs, :minor7),  (chord :Fs, :minor7),
].ring, 
]

set :chords, (get :phases)[0]


set :start_beats, true
set :use_midi_chord, nil

# default midi synths
set :midi_synth, :pretty_bell
# use mod triangle wave synth if modulation range is non zero
set :midi_mod_synth, :mod_tri


# uncomment to disable play flags toggle with midi keyboard
set :play_flags_keymap, nil

set :play_chords_odd, true

set :play_bass_root, false
set :play_bass_octave, false

set :play_cymbal_beat, false
set :play_cymbal_sub, true
set :play_drums_bass, true
set :play_drums_house, false

cue :phase, 1
#cue :start

