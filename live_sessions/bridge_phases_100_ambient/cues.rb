# ---- cues

set :start_beats, nil
set :use_midi_chord, nil

set :play_flags_keymap, [
  :play_bass_octave,     # C1
  :play_bass_base,
  :play_cymbal_beat,     # D1
  :play_cymbal_sub,
  :play_drums_house,     # E1
  :play_chords_odd,      # F1
  :play_chords_rnd,
  :play_chords_beat,     # G1
  :play_bells_rnd,
  :play_chords_rnd_beat, # A1
  :play_haunted,
  :play_ambient          # B1
]

cue :phase, 0
cue :start

live_loop :cues do
  br, ch = (sync :bar)
  if not get :play_flags_keymap then
    set :play_bass_octave, nil
    set :play_bass_octave, true if (get :n_bar).between?(16,31)
    set :play_bass_base, nil
    set :play_bass_base, true if (get :n_bar) < 16 or (get :n_bar) >= 64
    set :play_cymbal_beat, nil
    set :play_cymbal_beat, true if (get :n_bar) < 24
    set :play_cymbal_sub, nil
    set :play_cymbal_sub, true if (get :n_bar) >= 24
    set :play_drums_house, nil
    set :play_drums_house, true if (get :n_bar) >= 28
    set :play_chords_odd, nil
    set :play_chords_odd, true if (get :n_bar).between?(20,63)
    set :play_chords_rnd, nil
    set :play_chords_rnd, true if (get :n_bar).between?(48,63) and one_in 2
    set :play_chords_beat, nil
    set :play_chords_beat, true if (get :n_bar) < 32
    set :play_bells_rnd, nil
    set :play_bells_rnd, true if (get :n_bar).between?(72,95)
    set :play_chords_rnd_beat, nil
    set :play_chords_rnd_beat, true if (get :n_bar).between?(16,31)
    set :play_haunted, nil
    set :play_haunted, true if (get :n_bar) >= 84
    set :play_ambient, nil
    set :play_ambient, true if (get :n_bar).between?(68,80)
    cue :phase, 1 if (get :n_bar) == 62
  end
end
