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
(
  [ (chord :Fs, :minor7) ] * 8
).ring, 
]

set :chords, (get :phases)[0]


set :start_beats, true
set :use_midi_chord, nil

# default midi synths
set :midi_synth, :pretty_bell
# use mod triangle wave synth if modulation range is non zero
set :midi_mod_synth, :mod_tri

# intrument synths
set :keys_synth, :dpulse
set :bass_synth, :chipbass

# uncomment to disable play flags toggle with midi keyboard
set :play_flags_keymap, [
  :play_bass_octave,     # C1
  :play_bass_root,
  :play_flag_dummy,      # D1
  :play_cymbal_beat,     
  :play_cymbal_sub,      # E1
  :play_drums_bass,      # F1
  :play_drums_house,
  :play_chords_odd,      # G1
  :play_flag_dummy
]

# clear play flags
for flag in (get :play_flags_keymap) do
    set flag, false
end

# play flags mappings per live loop
play_flags_bass_offset = 0
play_flags_bass = [
  nil, #:play_bass_octave,     # C1
  nil, #:play_bass_root,
]
play_flags_cymbal_offset = 3
play_flags_cymbal = [
  nil, #:play_cymbal_beat,     
  1, #:play_cymbal_sub,      # E1
]
play_flags_drums_offset = 5
play_flags_drums = [
  1, #:play_drums_bass,      # F1
  nil, #:play_drums_house,
]
play_flags_keys_offset = 7
play_flags_keys = [
  1, #:play_chords_odd,      # G1
]

# set play flags
for i in (0..play_flags_bass.length()-1) do
      set (get :play_flags_keymap)[i + play_flags_bass_offset], play_flags_bass[i]
end
for i in (0..play_flags_cymbal.length()-1) do
      set (get :play_flags_keymap)[i + play_flags_cymbal_offset], play_flags_cymbal[i]
end
for i in (0..play_flags_drums.length()-1) do
      set (get :play_flags_keymap)[i + play_flags_drums_offset], play_flags_drums[i]
end
for i in (0..play_flags_keys.length()-1) do
      set (get :play_flags_keymap)[i + play_flags_keys_offset], play_flags_keys[i]
end

cue :phase, 0
cue :start

