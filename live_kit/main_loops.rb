#  ---- ----  ----  ---- live loops synchro

# ---- start

sync :start
use_bpm get(:bpm)

# ---- main live loop

# current bar in phase / chord progression
i_bar = 0
# current beat in bar
i_beat = 0
# total bars count
set :n_bar, 0

# update chord progression, send cues for beats and bars  
live_loop :bar_beats do
  # count beats during one bar for start
  if get :start_beats
    (get :beats).times do
      sample :drum_cymbal_closed
      sleep 1
    end
  end
  # cycle bars in current phase / chord progression
  while true do
    # set current chord from the midi keyboard if overriding
    if get :use_midi_chord
      set :chrd, (get :midi_chrd)
    # or pick next chord in the phase
    else
      set :chrd, (get :chords).tick
    end
    # cue current bar and chord
    cue :bar, i_bar, (get :chrd)
    # cycle beats in bar
    (get :beats).times do
      # set current chord from the midi keyboard if overriding
      set :chrd, (get :midi_chrd) if get :use_midi_chord
      # cue current beat and chord
      cue :beat, i_beat, (get :chrd)
      # wait 1 beat and increment current beat
      sleep 1
      i_beat = (i_beat + 1) % (get :beats)
    end
    # increment current bar and total bar count
    i_bar = (i_bar + 1) % (get :chords).length()
    set :n_bar, (get :n_bar) + 1
  end
end
  
# movement phases / change chord progression
live_loop :movement_phases do
  # sync on phase change
  i_phase = (sync :phase)[0]
  # sync current bar
  i_bar = (sync :bar)[0]
  # up to the last bar of the chord progressiob
  while i_bar != (get :chords).length() - 1 do
    i_bar = (sync :bar)[0]
  end
  # change phase to the next chord progression 
  set :chords, (get :phases)[i_phase % (get :phases).length()]
  cue :phase_changed, i_phase
end
