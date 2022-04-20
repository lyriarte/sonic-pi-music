# ---- drum n bass

sync :start
use_bpm get(:bpm)


live_loop :bass_beat do
  bt, ch = (sync :beat)
end

live_loop :bass_bar do
  br, ch = (sync :bar)
  bass_blues_rock_4 ch, br if (get :play_bass_rock)
  acid_bass_bar ch, br if (get :play_bass_acid)
end

live_loop :cymbals_beat do
  bt, ch = sync :beat
  sample :drum_cymbal_closed, amp: 0.5 if (get :play_cymbal_beat)
  drums_cymbals_sub_beat (get :sub_beat) if (get :play_cymbal_sub)
end

live_loop :drums_beat do
  bt, ch = sync :beat
end

live_loop :drums_bar do
  br, ch = sync :bar
  drums_sparse_beat_4 if (get :play_drums_sparse)
  drums_binary_beat_4 if (get :play_drums_binary)
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

# sparse beat, 4 beats per bar
define :drums_sparse_beat_4 do | am=1|
  sample :drum_bass_hard, amp: am
  sleep 2
  sample :drum_snare_hard, amp: am
end

# binary beat, 4 beats per bar
define :drums_binary_beat_4 do | am=1|
  sample :drum_bass_hard, amp: am
  sleep 1
  sample :drum_snare_hard, amp: am
  sleep 0.5
  sample :drum_bass_hard, amp: am
  sleep 0.5
  sample :drum_bass_hard, amp: am
  sleep 1
  sample :drum_snare_hard, amp: am
  #sleep 1
end



# ---- ---- ---- ---- bass

# blues rock bass, 4 beats per bar
define :bass_blues_rock_4 do | ch, br, am=1, sy=:subpulse |
  with_synth sy do
    with_octave -2 do
      if br % 2 == 0 then
        3.times do
          play ch[0], release:0.2, amp: am
          sleep 0.5
        end
        2.times do
          play ch[0] - 5, release:0.2, amp: am
          sleep 0.5
          play ch[0] - 2, release:0.2, amp: am
          sleep 0.5
        end
        play ch[0], release: 1, amp: am
      else
        sleep 0.5
        2.times do
          play ch[0], release:0.2, amp: am
          sleep 0.5
        end
        2.times do
          play ch[0] - 5, release:0.2, amp: am
          sleep 0.5
          play ch[0] - 2, release:0.2, amp: am
          sleep 0.5
        end
      end
    end
  end
end


# acid house pattern
define :acid_bass_bar do | ch, br, am=1, sy=:subpulse |
  with_synth sy do
    with_octave -2 do
      if br % 2 == 0 then
        [0,0.25,0.25,0.25,0.25,0.25].each do | i |
          sleep i
          play ch[0], release: 0.2
        end
        sleep 0.25
        play ch[0], release: 2, decay: 0.5
        sleep 2
      else
        [0.25,0.25,0.5].each do | i |
          play ch[0], release: 0.2
          sleep i
        end
        3.times do
          [0.25,0.5].each do | i |
            play ch[0], release: 0.2
            sleep i
          end
        end
        play ch[0], release: 0.2
      end
    end
  end
end