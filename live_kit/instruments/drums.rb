# ---- ---- ---- ---- cymbals and drums

sync :start
use_bpm get(:bpm)


# ---- live loops

live_loop :cymbals do
  sync :beat
  drums_cymbals_sub_beat sb = get(:sub_beat)
end

live_loop :drums do
  sync :bar
  drums_bass_disco_beat
end



# ---- ---- cymbals

# ---- sync :beat

# hi hat on sub beat
define :drums_cymbals_sub_beat do | sb=4, am=1|
  sample :drum_cymbal_closed, amp: 0.5 * am
  (sb - 1).times do
    sleep 1/Float(sb)
    sample :drum_cymbal_closed, amp: 0.25 * am
  end
  #sleep 1/sb
end

# hi hat open on beat
define :drums_cymbals_hh_open_beat do | sb=4, am=1|
  sample :drum_cymbal_open, amp: 0.5 * am
  sleep 1/Float(sb)
  (sb - 2).times do
    sleep 1/Float(sb)
    sample :drum_cymbal_closed, amp: 0.5 * am
  end
  #sleep 1/sb
end

# ---- sync :bar

# swing cymbals for ternary sub beat, 4 beats per bar
define :drums_cymbals_swing_sub_3_beat_4 do | sb=3, am=1|
  sample :drum_cymbal_open, amp: 0.25 * am, finish: 0.15
  sleep 1
  sample :drum_cymbal_closed, amp: 0.5 * am
  sleep (1/Float(sb) * (sb - 1))
  sample :drum_cymbal_closed, amp: 0.5 * am
  sleep 1/Float(sb)
  sample :drum_cymbal_open, amp: 0.25 * am, finish: 0.15
  sleep 1
  sample :drum_cymbal_closed, amp: 0.5 * am
  sleep (1/Float(sb) * (sb - 1))
  sample :drum_cymbal_closed, amp: 0.5 * am
  #sleep 1/Float(sb)
end

# swing cymbals for double ternary sub beat
define :drums_cymbals_swing_sub_double_3 do | sb=3, am=1|
  sleep 0.5
  sample :drum_cymbal_closed, amp: 0.5 * am
  sleep (1/Float(sb) * (sb - 1)) / 2
  sample :drum_cymbal_closed, amp: 0.5 * am
  sleep 1/Float(sb) / 2
  sample :drum_cymbal_open, amp: 0.25 * am, finish: 0.15
end



# ---- ---- drums

# ---- sync :beat

# bass drum disco beat
define :drums_bass_disco_beat do | am=1|
  sample :drum_bass_hard, amp: 1.25 * am, rate: 2
  #sleep 1
end


# ---- sync :bar

# sparse beat, 4 beats per bar
define :drums_sparse_beat_4 do | am=1|
  sample :drum_bass_hard, amp: am
  sleep 2
  sample :drum_snare_hard, amp: am
  #sleep 2
end

# base beat, 4 beats per bar
define :drums_base_beat_4 do | am=1|
  sample :drum_bass_hard
  sleep 1
  sample :drum_bass_hard, amp: 0.5 * am
  sleep 1
  sample :drum_snare_hard, amp: 0.5 * am
  sleep 1
  sample :drum_bass_hard, amp: 0.5 * am
  #sleep 1
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

# double beat, 4 beats per bar
define :drums_double_beat_4 do | am=1|
  sample :drum_bass_hard, amp: am
  sleep 0.5
  sample :drum_snare_hard, amp: am
  sleep 0.5
  sample :drum_bass_hard, amp: am
  sleep 0.5
  sample :drum_snare_hard, amp: am
  sleep 0.5
  sample :drum_bass_hard, amp: am
  sleep 0.5
  sample :drum_snare_hard, amp: am
  sleep 0.5
  sample :drum_bass_hard, amp: am
  sleep 0.25
  sample :drum_bass_hard, amp: am
  sleep 0.25
  sample :drum_snare_hard, amp: am
  #  sleep 0.5
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

# bossa beat, 4 beats per bar
define :drums_bossa_beat_4 do | am=1|
  sample :drum_bass_hard, amp: 0.5 * am
  sleep 0.5
  sample :drum_snare_soft, amp: 0.25 * am
  sleep 0.75
  sample :drum_snare_soft, amp: 0.25 * am
  sleep 0.75
  sample :drum_snare_soft, amp: 0.25 * am
  sleep 0.75
  sample :drum_snare_soft, amp: 0.25 * am
  sleep 0.75
  sample :drum_snare_soft, amp: 0.25 * am
end



