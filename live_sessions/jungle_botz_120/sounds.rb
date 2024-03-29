# ---- sounds

sync :start
use_bpm get(:bpm)

live_loop :keys_beat do
  use_synth :dpulse
  bt, ch = (sync :beat)
  keys_chords_odd_sub_beat ch, am=4 if (get :play_chords_odd)
  keys_rnd_dbl_sub_beat ch, sb=4 if (get :play_chords_rnd_beat)
end

live_loop :keys_bar do
  use_synth :dpulse
  br, ch = (sync :bar)
  if (get :play_chords_slide)
    n = rrand_i(1, (get :beats))
    ((get :beats) / n).times do
      keys_rnd_bar_slide ch, nb=n, am=1, sy=:dpulse
      sleep n/2
    end
  end
  with_fx :ixi_techno do
    play ch, amp: 0.5, attack: rrand(0, 1), release: rrand(0.5, (get :beats)) if (get :play_chords_bar)
  end
end

live_loop :sounds_beat do
  bt, ch = (sync :beat)
  rnd = rrand(0,1)
  sample (choose [:mehackit_robot1, :mehackit_robot3, :mehackit_robot5]), amp: 2 if (get :play_robot)
  sample (choose [:mehackit_robot1, :mehackit_robot3, :mehackit_robot5]), amp: 2 if (get :play_robot_rnd) and rnd.between?(0,0.05)
end

live_loop :sounds_bar do
  br, ch = (sync :bar)
  keys_rnd_dbl_sub_beat ch if (get :play_chords_rnd_bar)
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
      play ch.choose, release:0.05, amp: am, pan: (rrand -1, 1)
    end
  end
end


