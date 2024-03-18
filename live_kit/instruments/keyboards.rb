# ---- ---- ---- ---- keyboards

set :keys_play_flags, [
  # beat
  :play_keys_chords_beat,
  :play_keys_chords_odd_sub_beat,
  :play_keys_rnd_dbl_sub_beat,
  :play_keys_rnd_sub_slide,
  # bar
  :play_keys_chords_bar,
  :play_keys_rnd_bar_slide,
  :play_bar_slide,
  :play_keys_latin_2_bar_4,
  :play_keys_bar_house
]

sync :start
use_bpm get(:bpm)


# ---- live loops

live_loop :keys_beat do
  bt, ch = (sync :beat)
  keys_chords_beat ch if (get :play_keys_chords_beat)
  keys_chords_odd_sub_beat ch if (get :play_keys_chords_odd_sub_beat)
  keys_rnd_dbl_sub_beat ch, (get :sub_beat) if (get :play_keys_rnd_dbl_sub_beat)
  keys_rnd_sub_slide ch, (get :sub_beat) if (get :play_keys_rnd_sub_slide)
end

live_loop :keys_bar do
  br, ch = (sync :bar)
  keys_chords_bar ch, (get :beats) if (get :play_keys_chords_bar)
  keys_rnd_bar_slide ch, (get :beats) if (get :play_keys_rnd_bar_slide)
  bar_slide ch, (get :beats) if (get :play_bar_slide)
  keys_latin_2_bar_4 ch, (get :beats) if (get :play_keys_latin_2_bar_4)
  keys_bar_house ch, (get :beats) if (get :play_keys_bar_house)
end

# ---- sync :beat

# one chord per beat
define :keys_chords_beat do | ch, am=1, sy=:beep |
  with_synth sy do
    play ch, amp: am, release: 0.8
  end
end

# short chord odd sub beat
define :keys_chords_odd_sub_beat do | ch, am=1, sy=:beep |
  with_synth sy do
    sleep 0.5
    play ch, amp: am, release: 0.1
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

# short double sub slide
define :keys_rnd_sub_slide do | ch, sb=4, am=1, sy=:beep |
  with_synth sy do
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
end

# ---- sync :bar

# one chord per bar
define :keys_chords_bar do | ch, nb=4, am=1, sy=:beep |
  with_synth sy do
    play ch, amp: am, release: nb
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

# slide within random notes in the current chord
define :bar_slide do | ch, nb=4, am=1, sy=:beep |
  with_synth sy do
    n0 = ch.choose()
    (nb - 1).times do
      n1 = ch.choose
      p0 = play n0, note_slide: 1
      control p0, note: n1
      sleep 1
      n0 = n1
    end
    play n0
  end
end

# latin clave on 2 bars
define :keys_latin_2_bar_4 do | ch, br, am=1, sy=:fm |
  with_synth sy do
    if br % 2 == 0 then
      play ch, amp: am, release: 0.2
      sleep 1
      play ch, amp: am, release: 0.2
      sleep 1.5
      play ch, amp: am, release: 0.2
      sleep 1
      play ch, amp: am, release: 0.2
    else
      sleep 0.5
      play ch, amp: am, release: 0.2
      sleep 1
      play ch, amp: am, release: 0.2
    end
  end
end

# acid house pattern
define :keys_bar_house do | ch, nb=4, am=1, sy=:dpulse |
  with_synth sy do
    [0,0.25,0.25,0.25,0.25,0.25].each do | i |
      sleep i
      play_chord ch, release: 0.2
    end
    sleep 0.25
    play_chord ch, release: 2, decay: 0.5
    [2,0.25,0.25].each do | i |
      sleep i
      play_chord ch, release: 0.2
    end
  end
end
