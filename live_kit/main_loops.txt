#  ---- ----  ----  ---- live loops synchro

# ---- start

sync :start
use_bpm get(:bpm)

# ---- main live loop

i_bar = 0
i_beat = 0

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
  end
end

  
  
  