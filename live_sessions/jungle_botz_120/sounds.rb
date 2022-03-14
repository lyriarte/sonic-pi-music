# ---- sounds

sync :start
use_bpm get(:bpm)

live_loop :keys do
  use_synth :tb303
#  bt, ch = (sync :beat)
#  keys_chords_odd_sub_beat ch, am=0.5
  br, ch = (sync :bar)
  play ch, amp: 0.5, attack: 0.2, release: 0.4
end

live_loop :sounds do
#  bt, ch = (sync :beat)
  br, ch = (sync :bar)
#  keys_rnd_dbl_sub_beat ch
end


# ---- ---- ---- ---- keyboards

# short chord odd sub beat
define :keys_chords_odd_sub_beat do | ch, am=1, sy=:tb303 |
  with_synth sy do
    sleep 0.5
    play ch, amp: am, release: 0.1
  end
end

# short double sub random
define :keys_rnd_dbl_sub_beat do | ch, sb=4, am=1, sy=:tb303 |
  with_synth sy do
    play ch.choose, release: 0.05
    (2*sb - 1).times do
      sleep 1/Float(2*sb)
      play ch.choose, release:0.05, amp: am
    end
  end
end

