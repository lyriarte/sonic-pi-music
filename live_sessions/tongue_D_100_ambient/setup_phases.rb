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
  :play_bass_octave_odd_beat,# C1
  :play_bass_sub_beat,
  :play_flag_dummy,      # D1
  :play_cymbals_beat,
  :play_cymbals_sub_beat,# E1
  :play_drums_bass_disco_beat,      # F1
  :play_drums_house_odd_snare,
  :play_keys_chords_odd_sub_beat,      # G1
  :play_keys_chords_bar,
  :play_flag_dummy
]

# auto play by movement, in sequence, random mode, otherwise manual
set :auto_play_mode, "movement" # , "sequence" , "random", nil

set :movements_map, {
  "intro" => { "phase" => 0, "flags" => [:play_keys_chords_bar, :play_cymbals_beat]},
  "overture octave"  => { "phase" => 0, "flags" => [:play_bass_octave_odd_beat, :play_keys_chords_bar, :play_cymbals_sub_beat]},
  "overture double"  => { "phase" => 0, "flags" => [:play_bass_sub_beat, :play_drums_bass_disco_beat, :play_keys_chords_odd_sub_beat, :play_cymbals_sub_beat]},
  "overture house"  => { "phase" => 0, "flags" => [:play_bass_sub_beat, :play_drums_house_odd_snare, :play_keys_chords_odd_sub_beat, :play_cymbals_sub_beat]},
  "bridge octave"  => { "phase" => 1, "flags" => [:play_bass_octave_odd_beat, :play_keys_chords_bar, :play_cymbals_sub_beat, :play_drums_bass_disco_beat]},
  "bridge house"  => { "phase" => 1, "flags" => [:play_bass_octave_odd_beat, :play_cymbals_sub_beat, :play_drums_house_odd_snare]},
  "re overture dub"  => { "phase" => 0, "flags" => [:play_keys_chords_bar, :play_cymbals_beat]},
  "outro house"  => { "phase" => 2, "flags" => [:play_bass_octave_odd_beat, :play_keys_chords_bar, :play_cymbals_sub_beat]}
}

live_loop :cues do
  br, ch = (sync :bar)
  # toggle play flags according to total bars count if there is no keymap
  case get :auto_play_mode
  when "movement"
    nb = (get :n_bar)
    if nb < 8
      cue :movement, "intro"
    elsif nb < 16
      cue :movement, "overture octave"
    elsif nb < 24
      cue :movement, "overture double"
    elsif nb < 48
      cue :movement, "overture house"
    elsif nb < 56
      cue :movement, "bridge octave"
    elsif nb < 72
      cue :movement, "bridge house"
    elsif nb < 88
      cue :movement, "re overture dub"
    elsif nb < 96
      cue :movement, "outro house"
    else
      set :auto_play_mode, nil
    end
  end
end

cue :start
cue :movement, "intro"

