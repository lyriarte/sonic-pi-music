# ---- drum n bass

sync :start
use_bpm get(:bpm)


live_loop :bass_beat do
  bt, ch = (sync :beat)
  bass_root_rnd ch if (get :play_bass_root)
  bass_rnd_double_beat ch if (get :play_bass_rnd)
  bass_octave_double_beat ch if (get :play_bass_octave)
end

live_loop :cymbals_beat do
  bt, ch = sync :beat
  sample :drum_cymbal_closed, amp: 0.5 if (get :play_cymbal_beat)
  drums_cymbals_sub_beat (get :sub_beat) if (get :play_cymbal_sub)
end

live_loop :drums_beat do
  bt, ch = sync :beat
  sample :drum_bass_hard, amp: 0.5 if (get :play_drums_bass)
end

live_loop :drums_bar do
  br, ch = sync :bar
  drums_jungle_beat_4 if (get :play_drums_jungle)
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
define :bass_rnd_double_beat do | ch, am=1, sy=:chipbass |
  with_synth sy do
    with_octave -2 do
      play choose(ch), release:0.2, amp: am
      sleep 0.5
      play choose(ch), release:0.2, amp: am
    end
  end
end

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
define :bass_root_rnd do | ch, nb=4, am=1, sy=:chipbass |
  with_synth sy do
    with_octave -2 do
      play ch[0], release:0.2, amp: 1.5 * am
      beat_left = nb 
      loop do
        beat_delay = choose([0.5,1,1.5,2])
        beat_left = beat_left - beat_delay
        if beat_left <= 0
          break
        end
        sleep beat_delay
        play ch.pick, release:0.2, amp: 1.5 * am
      end
    end
  end
end

