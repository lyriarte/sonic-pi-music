# ---- ---- ---- ---- keyboards

sync :start
use_bpm get(:bpm)

live_loop :keys_beat do
  bt, ch = (sync :beat)
  keys_chords_odd_sub_beat ch, am=4, sy=(get :keys_synth) if (get :play_chords_odd)
end

# ---- drum n bass

live_loop :bass_beat do
  bt, ch = (sync :beat)
  bass_root_sub ch if (get :play_bass_root)
  bass_octave_double_beat ch, sb=(get :sub_beat) if (get :play_bass_octave)
end

live_loop :cymbals_beat do
  bt, ch = sync :beat
  sample :drum_cymbal_closed, amp: 0.5 if (get :play_cymbal_beat)
  drums_cymbals_sub_beat (get :sub_beat) if (get :play_cymbal_sub)
end

live_loop :drums_beat do
  bt, ch = sync :beat
  sample :drum_bass_hard, amp: 0.5 if (get :play_drums_bass)
  drums_house_odd_snare bt if (get :play_drums_house)
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
define :bass_octave_double_beat do | ch, am=1, sy=:chipbass |
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

# random delay, root chord on first beat
define :bass_root_sub do | ch, sb=4, am=1, sy=:chipbass |
  with_synth sy do
    with_octave -2 do
      play ch[0], release:0.2, amp: 1.5 * am
      (sb - 1).times do
        sleep 1/Float(sb)
        play ch[0], release:0.2, amp: 1.5 * am
      end
    end
  end
end


# ---- ---- ---- ---- keys

# short chord odd sub beat
define :keys_chords_odd_sub_beat do | ch, am=1, sy=:beep |
  with_synth sy do
    sleep 0.5
    play ch, amp: am, release: 0.1
  end
end

