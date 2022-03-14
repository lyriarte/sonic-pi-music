# ---- drum n bass

sync :start
use_bpm get(:bpm)


live_loop :bass do
  bt, ch = (sync :beat)
#  bass_rnd_double_beat ch
#  bass_octave_double_beat ch
#  br, ch = (sync :bar)
end

live_loop :cymbals do
  bt, ch = sync :beat
#  sample :drum_cymbal_closed, amp: 0.5
#  drums_cymbals_sub_beat (get :sub_beat)
end

live_loop :drums do
  bt, ch = sync :beat
  sample :drum_bass_hard, amp: 0.5
#  br, ch = sync :bar
#  drums_jungle_beat_4
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

# jungle beat, 4 beats per bar
define :drums_jungle_beat_4 do | am=1|
  sample :drum_bass_hard, amp: 0.5 * am
  sleep 0.5
  sample :drum_bass_hard, amp: 0.25 * am
  sleep 0.5
  sample :drum_snare_hard, amp: 0.5 * am
  sleep 0.5
  sample :drum_bass_hard, amp: 0.25 * am
  sleep 0.25
  sample :drum_snare_hard, amp: 0.25 * am
  sleep 0.25
  sample :drum_bass_hard, amp: 0.25 * am
  sleep 0.25
  sample :drum_snare_hard, amp: 0.25 * am
  sleep 0.25
  sample :drum_bass_hard, amp: 0.25 * am
  sleep 0.5
  sample :drum_snare_hard, amp: 0.25 * am
  sleep 0.5
  sample :drum_bass_hard, amp: am
  sleep 0.25
  sample :drum_snare_hard, amp: am
  #sleep 0.25
end

# ---- ---- ---- ---- bass

# random chord 2 notes per beat
define :bass_rnd_double_beat do | ch, am=1, sy=:beep |
  with_synth sy do
    with_octave -2 do
      play choose(ch), release:0.2, amp: am
      sleep 0.5
      play choose(ch), release:0.2, amp: am
    end
  end
end

# octave 2 notes per beat
define :bass_octave_double_beat do | ch, am=1, sy=:beep |
  with_synth sy do
    with_octave -2 do
      play ch[0], release:0.2, amp: am
      sleep 0.5
      with_transpose 12 do
        play ch[0], release:0.2, amp: am
      end
    end
  end
end
