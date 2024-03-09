# ---- ---- ---- ---- keyboards

sync :start
use_bpm get(:bpm)


# ---- keys

live_loop :keys_bar do
  br, ch = (sync :bar)
  keys_chords_bar ch, nb=(get :beats), am=0.5, sy=(get :keys_synth) if (get :play_chords_bar)
end

# ---- drum n bass

live_loop :bass_beat do
  bt, ch = (sync :beat)
  bass_root_sub ch, sb=(get :sub_beat), am=1, sy=(get :bass_synth)  if (get :play_bass_root)
end

live_loop :cymbals_beat do
  bt, ch = sync :beat
  sample :drum_cymbal_closed, amp: 0.5 if (get :play_cymbal_beat)
end

live_loop :drums_beat do
  bt = (sync :beat)[0]
  drums_house_odd_snare bt if (get :play_drums_house)
end

# ---- ---- ---- ---- cymbals and drums

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

# sub beat root bass
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

define :keys_chords_bar do | ch, nb=4, am=1, sy=:beep |
  with_synth sy do
    play ch, amp: am, release: nb, attack: 0.5
  end
end


