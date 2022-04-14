# ---- drum n bass

sync :start
use_bpm get(:bpm)


live_loop :bass_beat do
  bt, ch = (sync :beat)
end

live_loop :bass_bar do
  br, ch = (sync :bar)
  bass_blues_rock_4 ch, br
end

live_loop :cymbals_beat do
  bt, ch = sync :beat
  sample :drum_cymbal_closed, amp: 0.5
end

live_loop :drums_beat do
  bt, ch = sync :beat
end

live_loop :drums_bar do
  br, ch = sync :bar
end


# ---- ---- ---- ---- cymbals and drums


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
