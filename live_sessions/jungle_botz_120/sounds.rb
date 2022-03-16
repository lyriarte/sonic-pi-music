# ---- sounds

sync :start
use_bpm get(:bpm)

live_loop :keys do
  use_synth :dpulse
#  bt, ch = (sync :beat)
#  keys_chords_odd_sub_beat ch, am=1
  br, ch = (sync :bar)
#  n = rrand_i(1, (get :beats))
#  ((get :beats) / n).times do
#    keys_rnd_bar_slide ch, nb=n, am=1
#    sleep n/2
#  end
  with_fx :ixi_techno do
    play ch, amp: 0.5, attack: rrand(0, 1), release: rrand(0.5, (get :beats))
  end
end

live_loop :sounds do
  bt, ch = (sync :beat)
  sample (choose [:mehackit_robot1, :mehackit_robot3, :mehackit_robot5]), amp: 2 if one_in(30)
#  br, ch = (sync :bar)
#  keys_rnd_dbl_sub_beat ch
end


# ---- ---- ---- ---- keyboards

# short chord odd sub beat
define :keys_chords_odd_sub_beat do | ch, am=1, sy=:beep |
  with_synth sy do
    sleep 0.5
    play ch, amp: am, release: 0.1
  end
end

# bar slide 
define :keys_rnd_bar_slide do | ch, nb=4, am=1, sy=:beep |
  with_synth sy do
    n0 = ch.choose()
    n1 = ch.choose()
    p0 = play n0, note_slide: nb, release: nb, amp: am
    control p0, note: n1
  end
end

# short double sub random
define :keys_rnd_dbl_sub_beat do | ch, sb=4, am=1, sy=:beep |
  with_synth sy do
    play ch.choose, release: 0.05
    (2*sb - 1).times do
      sleep 1/Float(2*sb)
      play ch.choose, release:0.05, amp: am
    end
  end
end


