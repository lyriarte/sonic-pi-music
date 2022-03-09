# ---- drum n bass

sync :start
use_bpm get(:bpm)


live_loop :bass do
  br, ch = (sync :bar)
  use_octave -2
  play ch[0]
  sleep 1.5
  play ch[0]
  sleep 0.5
  play ch[0]
end

live_loop :cymbals do
  bt = sync :beat
  sample :drum_cymbal_closed, amp: 0.5
end

live_loop :drums do
  sync :bar
end
