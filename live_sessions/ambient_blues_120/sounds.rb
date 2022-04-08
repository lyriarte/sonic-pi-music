# ---- sounds

sync :start
use_bpm get(:bpm)

live_loop :keys_beat do
  bt, ch = (sync :beat)
end

live_loop :keys_bar do
  br, ch = (sync :bar)
  play ch
end

live_loop :sounds_beat do
  bt, ch = (sync :beat)
end

live_loop :sounds_bar do
  br, ch = (sync :bar)
end


# ---- ---- ---- ---- keyboards


