# ---- drum n bass

sync :start
use_bpm get(:bpm)


live_loop :bass_beat do
  bt, ch = (sync :beat)
  bass_octave_double_beat ch if (get :play_bass_octave) # (get :n_bar).between?(16,31)
end

live_loop :bass_bar do
  br, ch = (sync :bar)
  bass_base_beat ch if (get :play_bass_base) # (get :n_bar) < 16 or (get :n_bar) >= 64
end

live_loop :cymbals_beat do
  bt, ch = sync :beat
  sample :drum_cymbal_closed, amp: 0.5 if (get :play_cymbal_beat) # (get :n_bar) < 24
  drums_cymbals_sub_beat (get :sub_beat) if (get :play_cymbal_sub) # (get :n_bar) >= 24
end

live_loop :drums_beat do
  bt, ch = sync :beat
  drums_house_odd_snare bt if (get :play_drums_house) # (get :n_bar) >= 28
end


# ---- ---- ---- ---- cymbals and drums

# hi hat on sub beat
define :drums_cymbals_sub_beat do | sb=4, am=1|
  sample :drum_cymbal_closed, amp: 0.5 * am
  (sb - 1).times do
    sleep 1/Float(sb)
    sample :drum_cymbal_closed, amp: 0.25 * am
  end
end

# open hi hat on half beat, snare on 2 and 4
define :drums_house_odd_snare do | bt, am=1|
  if (bt % 2) == 0
    sample :drum_heavy_kick, amp: am
  else
    sample :drum_snare_hard, amp: am
  end
  sleep 0.5
  sample :drum_cymbal_pedal, amp: am
end

# ---- ---- ---- ---- bass

# octave 2 notes per beat
define :bass_octave_double_beat do | ch, am=1, sy=:beep |
  with_synth sy do
    with_octave -2 do
      play ch[0], release:0.2, amp: am, pan: -0.8
      sleep 0.5
      with_transpose 12 do
        play ch[0], release:0.2, amp: am, pan: 0.8
      end
    end
  end
end

# base bass beat, 4 beats per bar
define :bass_base_beat do | ch, nb=4, am=1, sy=:beep |
  with_synth sy do
    with_octave -2 do
      play ch[0], amp: am
      sleep 1.5
      play ch[0], amp: am
      sleep 0.5
      play ch[0], amp: am
    end
  end
end

