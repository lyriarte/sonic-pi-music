# ---- sounds

sync :start
use_bpm get(:bpm)

live_loop :keys_beat do
  bt, ch = (sync :beat)
  keys_chords_odd_sub_beat ch, am=0.5 if (get :play_chords_odd) # (get :n_bar).between?(20,63)
  keys_rnd_dbl_sub_beat ch, (get :sub_beat) if (get :play_chords_rnd) # (get :n_bar).between?(48,63) and one_in 2
end

live_loop :keys_bar do
  br, ch = (sync :bar)
  play ch, amp: 0.5 if (get :play_chords_beat) # (get :n_bar) < 32
  keys_rnd_penta_bells ch, am=0.5 if (get :play_bells_rnd) # (get :n_bar).between?(72,95) 
  keys_rnd_dbl_sub_beat ch, (get :sub_beat) if (get :play_chords_rnd_beat) # (get :n_bar).between?(16,31) 
end

live_loop :sounds_beat do
  bt, ch = (sync :beat)
  sample :ambi_haunted_hum, rate: (rrand -2, 2), beat_stretch: (rrand 1, (get :beats) * 2), pan: (rrand -1, 1) if (get :play_haunted) # (get :n_bar) >= 84 
end

live_loop :sounds_bar do
  br, ch = (sync :bar)
  keys_dark_ambi_rnd_chord ch if (get :play_ambient) # (get :n_bar).between?(68,80) 
end


# ---- ---- ---- ---- keyboards

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

# random pentatonic bells
define :keys_rnd_penta_bells do | ch, am=1 |
  if one_in(3)
      sy = :pretty_bell
  else
      sy = :dull_bell
  end
  with_synth sy do
    i=1
    while i>0.05 do 
      j = rrand(0, i, step: 0.05)
        play (scale ch[0], :minor_pentatonic).pick , amp: am, pan: 2*i-1
        sleep(j)
        i=i-j
    end
  end
end

# ---- ---- ---- ---- ambient

# dark ambience base chord plus random note
define :keys_dark_ambi_rnd_chord do | ch, am=1, sy=:dark_ambience |
  with_synth sy do
    play ch, amp: am, attack: 0.5, decay: 0.25, release: (get :beats)*2
    play (rrand ch[0], ch[0]+12, step: 1), amp: am, attack: 2, decay: 0.25, release: (get :beats)*1.5, pan: (rrand -1, 1)
  end
end

