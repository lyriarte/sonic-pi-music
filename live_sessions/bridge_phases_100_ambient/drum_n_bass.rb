# ---- drum n bass

sync :start
use_bpm get(:bpm)


live_loop :bass do
#  bt, ch = (sync :beat)
#  bass_octave_double_beat ch
  br, ch = (sync :bar)
  bass_base_beat ch
end

live_loop :cymbals do
  bt, ch = sync :beat
  sample :drum_cymbal_closed, amp: 0.5
#  drums_cymbals_sub_beat (get :sub_beat)
end

live_loop :drums do
  bt, ch = sync :beat
#  drums_house_odd_snare bt
#  br, ch = sync :bar
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
  use_synth sy
  use_octave -2
  play ch[0], release:0.2, amp: am
  sleep 0.5
  with_transpose 12 do
    play ch[0], release:0.2, amp: am
  end
end

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

