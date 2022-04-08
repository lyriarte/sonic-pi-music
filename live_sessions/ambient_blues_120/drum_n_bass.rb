# ---- drum n bass

sync :start
use_bpm get(:bpm)


live_loop :bass_beat do
  bt, ch = (sync :beat)

end

live_loop :cymbals_beat do
  bt, ch = sync :beat
  sample :drum_cymbal_closed, amp: 0.5
end

live_loop :drums_beat do
  bt, ch = sync :beat
end

live_loop :drums_bar do
  br, ch = sync :bar
end


# ---- ---- ---- ---- cymbals and drums
