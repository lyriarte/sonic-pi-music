# ---- sounds

sync :start
use_bpm get(:bpm)

live_loop :keys do
#  bt, ch = (sync :beat)
#  keys_chords_odd_sub_beat ch, am=0.5
#  keys_rnd_dbl_sub_beat ch, (get :sub_beat) if one_in (get :beats)
  br, ch = (sync :bar)
  play ch, amp: 0.5
#  with_synth :dark_ambience do
#    play ch, amp: 0.8, attack: 0.5, decay: 0.25, sustain: (get :beats), release: (get :beats)
#  end
#  keys_rnd_dbl_sub_beat ch, (get :sub_beat)
end


# ---- ---- ---- ---- keyboards

# short chord odd sub beat
define :keys_chords_odd_sub_beat do | ch, am=1, sy=:beep |
  use_synth sy
  sleep 0.5
  play ch, amp: am, release: 0.1
end

# short double sub random
define :keys_rnd_dbl_sub_beat do | ch, sb=4, am=1, sy=:beep |
  use_synth sy
  play ch.choose, release: 0.05
  (2*sb - 1).times do
    sleep 1/Float(2*sb)
    play ch.choose, release:0.05, amp: am
  end
end

