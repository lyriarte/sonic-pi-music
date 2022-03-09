#  ---- ----  ----  ---- live loops synchro

# ---- start

sync :start
use_bpm get(:bpm)

# ---- main live loop

i_bar = 0
i_beat = 0
set :n_bar, 0

live_loop :bar_beats do
  (get :beats).times do
    sample :drum_cymbal_closed
    sleep 1
  end
  while true do
    set :chrd, (get :chords).tick
    cue :bar, i_bar, (get :chrd)
    (get :beats).times do
      cue :beat, i_beat, (get :chrd)
      sleep 1
      i_beat = (i_beat + 1) % (get :beats)
    end
    i_bar = (i_bar + 1) % (get :chords).length()
    set :n_bar, (get :n_bar) + 1
  end
end
  
# movement phases
live_loop :movement_phases do
  i_phase = (sync :phase)[0]
  i_bar = (sync :bar)[0]
  while i_bar != (get :chords).length() - 1 do
    i_bar = (sync :bar)[0]
  end
  set :chords, (get :phases)[i_phase % (get :phases).length()]
  cue :phase_changed, i_phase
end
