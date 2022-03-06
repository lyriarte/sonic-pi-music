# ---- ---- ---- ---- bass

sync :start
use_bpm get(:bpm)


# ---- live loops

live_loop :bass do
  bt, ch = sync :beat
  bass_octave_odd_beat ch, bt
end



# ---- sync :beat

# bass sub beat
define :bass_sub_beat do | ch, sb=4, am=1, sy=:beep |
  use_synth sy
  use_octave -2
  play ch[0], release:0.2, amp: am
  (sb - 1).times do
    sleep 1/Float(sb)
    play ch[0], release:0.2, amp: am
  end
end

# random chord 2 notes per beat
define :bass_rnd_double_beat do | ch, am=1, sy=:beep |
  use_synth sy
  use_octave -2
  play choose(ch), release:0.2, amp: am
  sleep 0.5
  play choose(ch), release:0.2, amp: am
end

# octave 2 notes per beat
define :bass_octave_double_beat do | ch, am=1, sy=:beep |
  use_synth sy
  use_octave -2
  use_transpose 0
  play ch[0], release:0.2, amp: am
  sleep 0.5
  use_transpose 12
  play ch[0], release:0.2, amp: am
end

# octave on odd beat
define :bass_octave_odd_beat do | ch, bt, am=1, sy=:beep |
  use_synth sy
  use_octave -2
  if (bt % 2) == 0
    use_transpose 0
  else
    use_transpose 12
  end
  play ch[0]
end


# ---- sync :bar

# base bass beat, 4 beats per bar
define :bass_base_beat do | ch, nb=4, am=1, sy=:beep |
  use_synth sy
  use_octave -2
  play ch[0], amp: am
  sleep 1.5
  play ch[0], amp: am
  sleep 0.5
  play ch[0], amp: am
end

# walking bass, fundamental on first beat
define :bass_walking do | ch, nb=4, am=1, sy=:beep |
  use_synth sy
  use_octave -2
  play ch[0], release:0.2, amp: 1.5 * am
  (nb - 1).times do
    sleep 1
    play choose(ch), release:0.2, amp: am
  end
  #sleep 1
end

# latin bass, 4 beats per bar
define :bass_latin_beat_4 do | ch, am=1, sy=:beep |
  use_synth sy
  use_octave -2
  play ch[0], release:0.2, amp: 2 * am
  sleep 1.5
  play ch[2], release:0.2, amp: am
  sleep 0.5
  play ch[2], release:0.2, amp: am
  sleep 1.5
  play ch[2], release:0.2, amp: am
  #sleep 0.5
end

