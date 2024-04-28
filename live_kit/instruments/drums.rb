# ---- ---- ---- ---- cymbals and drums

set :drums_play_flags, [
  # cymbals beat
  :play_cymbals_beat,
  :play_cymbals_sub_beat,
  :play_cymbals_hh_open_beat,
  # cymbals bar
  :play_cymbals_swing_sub_3_beat_4,
  :play_cymbals_swing_sub_double_3,
  # drums beat
  :play_drums_house_odd_snare,
  :play_drums_bass_disco_beat,
  # drums bar
  :play_drums_sparse_beat_4,
  :play_drums_base_beat_4,
  :play_drums_binary_beat_4,
  :play_drums_double_beat_4,
  :play_drums_jungle_beat_4,
  :play_drums_bossa_beat_4
]

for flag in (get :drums_play_flags) do
  set flag, false
end

sync :start
use_bpm get(:bpm)


# ---- live loops

live_loop :cymbals_beat do
  bt, ch = sync :beat
  sample :drum_cymbal_closed, amp: 0.5 if (get :play_cymbals_beat)
  drums_cymbals_sub_beat sb = get(:sub_beat) if (get :play_cymbals_sub_beat)
  drums_cymbals_hh_open_beat sb = get(:sub_beat) if (get :play_cymbals_hh_open_beat)
end

live_loop :cymbals_bar do
  br, ch = (sync :bar)
  drums_cymbals_swing_sub_3_beat_4 sb = get(:sub_beat) if (get :play_cymbals_swing_sub_3_beat_4)
  drums_cymbals_swing_sub_double_3 sb = get(:sub_beat) if (get :play_cymbals_swing_sub_double_3)
end

live_loop :drums_beat do
  bt, ch = sync :beat
  drums_house_odd_snare bt if (get :play_drums_house_odd_snare)
  drums_bass_disco_beat if (get :play_drums_bass_disco_beat)
end

live_loop :drums_bar do
  br, ch = (sync :bar)
  drums_sparse_beat_4 if (get :play_drums_sparse_beat_4)
  drums_base_beat_4 if (get :play_drums_base_beat_4)
  drums_binary_beat_4 if (get :play_drums_binary_beat_4)
  drums_double_beat_4 if (get :play_drums_double_beat_4)
  drums_jungle_beat_4 if (get :play_drums_jungle_beat_4)
  drums_bossa_beat_4 if (get :play_drums_bossa_beat_4)
end



# ---- ---- drums + cymbals

# ---- sync :beat

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



