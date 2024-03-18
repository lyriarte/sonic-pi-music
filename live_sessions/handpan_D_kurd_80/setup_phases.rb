#  handpan_D_kurd 80 bpm setup

set :bpm, 80
set :beats, 4
set :sub_beat, 4

set :phases, [
  (
   [(chord :D4, :minor),  (chord :A3, :minor),
    (chord :A3, :minor),  (chord :D4, :minor)] * 2 +
   [(chord :Bb3,:major),  (chord :D4, :minor),
    (chord :Bb3,:major),  (chord :A3, :minor),
    (chord :Bb3,:major),  (chord :D4, :minor),
    (chord :G3, :minor),  (chord :A3, :minor)
   ]
  ).ring,
  (
   [(chord :Bb3,:major),  (chord :C4, :major),
    (chord :D4, :minor),  (chord :D4, :minor)] * 4
  ).ring,
]

set :chords, (get :phases)[0]


set :start_beats, true
set :use_midi_chord, nil

# default midi synths
set :midi_synth, :prophet
set :midi_mod_synth, :mod_pulse

# intrument synths
set :keys_synth, :prophet
set :bass_synth, :chipbass

# uncomment to disable play flags toggle with midi keyboard
set :play_flags_keymap, [
  :play_keys_chords_bar,     # C1
  :play_cymbals_beat,
  :play_bass_sub_beat,      # D1
  :play_drums_house_odd_snare,
  :play_keys_bar_house,   # E1
]

# auto play by movement, in sequence, random mode, otherwise manual
set :auto_play_mode, "movement" # , "sequence" , "random", nil

set :movements_map, {
  "ambient" => { "phase" => 0, "flags" => [:play_keys_chords_bar, :play_cymbals_beat]},
  "pulse" => { "phase" => 0, "flags" => [:play_keys_chords_bar, :play_cymbals_beat, :play_bass_sub_beat]},
  "bridge" => { "phase" => 1, "flags" => [:play_keys_bar_house, :play_cymbals_beat, :play_bass_sub_beat]},
  "house" => { "phase" => 0, "flags" => [:play_keys_bar_house, :play_drums_house_odd_snare]},
}
