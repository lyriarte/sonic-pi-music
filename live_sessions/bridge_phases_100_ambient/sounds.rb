# ---- sounds

sync :start
use_bpm get(:bpm)

live_loop :keys do
  br, ch = (sync :bar)
  play ch, amp: 0.2
end
