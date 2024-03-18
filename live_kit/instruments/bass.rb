# ---- ---- ---- ---- bass

set :bass_play_flags, [
  # beat
  :play_bass_sub_beat,
  :play_bass_rnd_double_beat,
  :play_bass_octave_double_beat,
  :play_bass_octave_odd_beat,
  # bar
  :play_bass_base_beat,
  :play_bass_walking,
  :play_bass_latin_beat_4,
  :play_bass_root_rnd
]

sync :start
use_bpm get(:bpm)


# ---- live loops

live_loop :bass_beat do
  bt, ch = (sync :beat)
  bass_sub_beat ch, sb = get(:sub_beat) if (get :play_bass_sub_beat)
  bass_rnd_double_beat ch if (get :play_bass_rnd_double_beat)
  bass_octave_double_beat ch if (get :play_bass_octave_double_beat)
  bass_octave_odd_beat ch, bt if (get :play_bass_octave_odd_beat)
end

live_loop :bass_bar do
  br, ch = (sync :bar)
  bass_base_beat ch, nb = get(:beats) if (get :play_bass_base_beat)
  bass_walking ch, nb = get(:beats) if (get :play_bass_walking)
  bass_latin_beat_4 ch if (get :play_bass_latin_beat_4)
  bass_root_rnd ch, nb = get(:beats) if (get :play_bass_root_rnd)
end



# ---- sync :beat

# bass sub beat
define :bass_sub_beat do | ch, sb=4, am=1, sy=:beep |
  with_synth sy do
    with_octave -2 do
      play ch[0], release:0.2, amp: am
      (sb - 1).times do
        sleep 1/Float(sb)
        play ch[0], release:0.2, amp: am
      end
    end
  end
end

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
      play ch[0], release:0.2, amp: am, pan: -0.8
      sleep 0.5
      with_transpose 12 do
        play ch[0], release:0.2, amp: am, pan: 0.8
      end
    end
  end
end

# octave on odd beat
define :bass_octave_odd_beat do | ch, bt, am=1, sy=:beep |
  with_synth sy do
    with_octave -2 do
      if (bt % 2) == 0
        play ch[0], release:0.2, amp: am, pan: -0.8
      else
        with_transpose 12 do
          play ch[0], release:0.2, amp: am, pan: 0.8
        end
      end
    end
  end
end


# ---- sync :bar

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

# walking bass, fundamental on first beat
define :bass_walking do | ch, nb=4, am=1, sy=:beep |
  with_synth sy do
    with_octave -2 do
      play ch[0], release:0.2, amp: 1.5 * am
      (nb - 1).times do
        sleep 1
        play choose(ch), release:0.2, amp: am
      end
    end
  end
end

# latin bass, 4 beats per bar
define :bass_latin_beat_4 do | ch, am=1, sy=:beep |
  with_synth sy do
    with_octave -2 do
      play ch[0], release:0.2, amp: 2 * am
      sleep 1.5
      play ch[2], release:0.2, amp: am
      sleep 0.5
      play ch[2], release:0.2, amp: am
      sleep 1.5
      play ch[2], release:0.2, amp: am
    end
  end
end

# random delay, root chord on first beat
define :bass_root_rnd do | ch, nb=4, am=1, sy=:beep |
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

