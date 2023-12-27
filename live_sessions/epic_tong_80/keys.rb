sync :start
use_bpm get(:bpm)

live_loop :keys_beat do
  use_synth :dpulse
  bt, ch = (sync :beat)
  with_fx :ixi_techno do
    play ch, amp: 0.5
  end
end
