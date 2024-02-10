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

# bridge phases ambient 100 bpm random mode
define :tongue_drum_ambient_100_movements do | movement |
  for flag in (get :play_flags_keymap) do
    set flag, false
  end
  case movement
  when "intro"
    set :play_bass_octave, true
    set :play_cymbal_beat, true
    cue :phase, 0
  when "overture octave"
    set :play_bass_octave, true
    set :play_chords_odd, true
    set :play_cymbal_sub, true
    cue :phase, 0
  when "overture double"
    set :play_bass_root, true
    set :play_drums_bass, true
    set :play_chords_odd, true
    set :play_cymbal_sub, true
    cue :phase, 0
  when "overture house"
    set :play_bass_root, true
    set :play_drums_house, true
    set :play_chords_odd, true
    set :play_cymbal_sub, true
    cue :phase, 0
  when "bridge octave"
    set :play_bass_octave, true
    set :play_cymbal_sub, true
    set :play_drums_bass, true
    cue :phase, 1
  when "bridge house"
    set :play_bass_octave, true
    set :play_cymbal_sub, true
    set :play_drums_house, true
    cue :phase, 1
  when "re ouverture dub"
    set :play_bass_root, true
    set :play_cymbal_sub, true
    cue :phase, 0
  when "outro house"
    set :play_bass_root, true
    set :play_drums_house, true
    set :play_chords_odd, true
    set :play_cymbal_sub, true
    cue :phase, 2
  end
end

tongue_drum_ambient_100_movements "intro"
cue :start

