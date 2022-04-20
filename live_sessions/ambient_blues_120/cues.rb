# ---- cues

set :start_beats, true
set :use_midi_chord, nil

# default midi synths
set :midi_synth, :hoover
set :midi_mod_synth, :mod_fm

play_flags = [
  :play_bass_rock, :play_bass_acid,
  :play_cymbal_beat, :play_cymbal_sub,
  :play_drums_sparse, :play_drums_binary,
  :play_chords_odd, :play_chords_bar, :play_chords_latin
]

define :set_play_flags do | flags, value = nil |
  flags.each do | i |
    set i, value
  end
end

play_lineups = [
  [:play_cymbal_beat, :play_drums_sparse, :play_chords_bar],
  [:play_bass_rock, :play_cymbal_sub, :play_drums_binary, :play_chords_latin],
  [:play_bass_acid, :play_cymbal_sub, :play_drums_sparse, :play_chords_odd],
]

set_play_flags play_flags, nil
set_play_flags play_lineups[0], true

cue :phase, 0
cue :start

live_loop :cues do
  br, ch = (sync :bar)
  if br % 16 == 0 then
    set_play_flags play_flags, nil
    set_play_flags (choose play_lineups), true
  end
end

