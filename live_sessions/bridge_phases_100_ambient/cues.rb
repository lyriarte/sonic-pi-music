# ---- cues

set :start_beats, nil
set :use_midi_chord, nil

cue :phase, 0
cue :start

live_loop :cues do
  br, ch = (sync :bar)
  cue :phase, 1 if (get :n_bar) >= 64 
end
