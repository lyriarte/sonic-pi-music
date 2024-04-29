#  handpan_D_kurd 120 bpm setup

set :bpm, 120
set :beats, 4
set :sub_beat, 4

set :phases, [
  (
   [(chord :D4, :minor),  (chord :C4, :major),
    (chord :A3, :minor),  (chord :Bb3,:major)
   ]
  ).ring,
  (
   [(chord :D4, :minor),  (chord :D4, :minor)] * 3 +
   [(chord :Bb3,:major),  (chord :C4, :major)]
  ).ring,
  (
   [(chord :D4, :minor),  (chord :D4, :minor)] * 2 +
   [(chord :C4, :major),  (chord :C4, :major)] * 2 +
   [(chord :Bb3,:major),  (chord :Bb3,:major)] * 2 +
   [(chord :C4, :major),  (chord :C4, :major)] * 2
  ).ring,
  (
   [(chord :C4, :major),  (chord :Bb4,:major),
    (chord :D4, :minor),  (chord :D4, :minor)] * 3 +
   [(chord :A4, :minor),  (chord :A4, :minor)] * 2
  ).ring,
  (
   [(chord :A4, :minor),  (chord :A4, :minor),
    (chord :Bb4,:major),  (chord :Bb4,:major)]
  ).ring,
]

set :chords, (get :phases)[0]


set :start_beats, true
set :use_midi_chord, nil

# default midi synths
set :midi_synth, :dpulse
set :midi_mod_synth, :mod_pulse

# intrument synths
set :keys_synth, :dpulse
set :bass_synth, :chipbass

# uncomment to disable play flags toggle with midi keyboard
set :play_flags_keymap, [
  :play_keys_chords_odd_sub_beat,     # C1
  :play_cymbals_beat,
  :play_bass_base_beat,# D1
]

for flag in (get :play_flags_keymap) do
  set flag, true
end

# auto play by movement, in sequence, random mode, otherwise manual
set :auto_play_mode, nil

