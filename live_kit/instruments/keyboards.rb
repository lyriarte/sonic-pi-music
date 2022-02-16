# ---- ---- ---- ---- keyboards

sync :start
use_bpm get(:bpm)


# ---- live loops

live_loop :keys do
  ch = (sync :beat)[1]
  keys_rnd_sub_slide ch, (get :sub_beat)
end

# ---- sync :beat

# one chord per beat
define :keys_chords_beat do | ch, am=1, sy=:blade |
  use_synth sy
  play ch, amp: am, release: 0.8
end

# short chord odd sub beat
define :keys_chords_odd_sub_beat do | ch, am=1, sy=:blade |
  use_synth sy
  sleep 0.5
  play ch, amp: am, release: 0.1
end

# short double sub random
define :keys_rnd_dbl_sub_beat do | ch, sb=4, am=1, sy=:blade |
  use_synth sy
  play ch.choose, release: 0.05
  (2*sb - 1).times do
    sleep 1/Float(2*sb)
    play ch.choose, release:0.05, amp: am
  end
end

# short double sub slide
define :keys_rnd_sub_slide do | ch, sb=4, am=1, sy=:blade |
  use_synth sy
  n0 = ch.choose()
  (sb - 1).times do
    n1 = ch.choose
    p0 = play n0, note_slide: 1/Float(sb), release: 1/Float(sb), amp: am
    control p0, note: n1
    sleep 1/Float(sb)
    n0 = n1
  end
  play n0, release: 1/Float(sb)
end

# ---- sync :bar

# one chord per bar
define :keys_chords_bar do | ch, nb=4, am=1, sy=:blade |
  use_synth sy
  play ch, amp: am, release: nb
end

# slide within random notes in the current chord
define :bar_slide do | ch, nb=4, am=1, sy=:blade |
  use_synth sy
  n0 = ch.choose()
  (nb - 1).times do
    n1 = ch.choose
    p0 = play n0, note_slide: 1
    control p0, note: n1
    sleep 1
    n0 = n1
  end
  play n0
  #sleep 1
end
