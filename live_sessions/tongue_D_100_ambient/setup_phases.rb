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
  (chord :G, :maj),  (chord :G, :maj)
].ring
]

set :chords, (get :phases)[0]


set :start_beats, nil
set :use_midi_chord, nil

# default midi synths
set :midi_synth, :pretty_bell
# use mod triangle wave synth if modulation range is non zero
set :midi_mod_synth, :mod_tri


# uncomment to disable play flags toggle with midi keyboard
set :play_flags_keymap, nil

set :play_cymbal_beat, false
set :play_bass_base, true
set :play_drums_house, false


cue :phase, 0
cue :start

