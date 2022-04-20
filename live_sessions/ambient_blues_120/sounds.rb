# ---- sounds

sync :start
use_bpm get(:bpm)

live_loop :keys_beat do
  bt, ch = (sync :beat)
  keys_chords_odd_sub_beat ch if (get :play_chords_odd)
end

live_loop :keys_bar do
  br, ch = (sync :bar)
  keys_chords_bar ch if (get :play_chords_bar)
  keys_latin_2_bar_4 ch, br if (get :play_chords_latin)
end

live_loop :sounds_beat do
  bt, ch = (sync :beat)
end

live_loop :sounds_bar do
  br, ch = (sync :bar)
end


# ---- ---- ---- ---- keyboards

# short chord odd sub beat
define :keys_chords_odd_sub_beat do | ch, am=1, sy=:piano |
  with_synth sy do
    sleep 0.5
    play ch, amp: am, release: 0.1
  end
end

# short chord odd sub beat
define :keys_chords_bar do | ch, am=1, sy=:dark_ambience |
  with_synth sy do
    play ch, attack: 0.5, release: 4
  end
end


# latin clave on 2 bars
define :keys_latin_2_bar_4 do | ch, br, am=1, sy=:piano |
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


