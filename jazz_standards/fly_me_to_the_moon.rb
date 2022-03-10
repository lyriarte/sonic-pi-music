# Fly me to the moon

set :bpm, 160
set :beats, 4
set :sub_beat, 3

set :start_beats, true

set :chords, [
  (chord :A, :minor7),  (chord :D, :minor7),
  (chord :G, :dom7),    (chord :C, :major7),
  
  (chord :F, :major7),  (chord :B, :dim7),
  (chord :E, :dom7),    (chord :A, :minor7),
  
  (chord :D, :minor7),  (chord :G, :dom7),
  (chord :C, :major7),  (chord :A, :minor7),
  
  (chord :D, :minor7),  (chord :G, :dom7),
  (chord :C, :major7),  (chord :E, :dom7)
].ring


# ---- instruments

# one chord per bar
define :keys_chords_bar do | ch, nb=4, am=1, sy=:beep |
  use_synth sy
  play ch, amp: am, release: nb
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

# base beat, 4 beats per bar
define :drums_base_beat_4 do | am=1|
  sample :drum_bass_soft, amp: am
  sleep 1
  sample :drum_bass_soft, amp: 0.5 * am
  sleep 1
  sample :drum_snare_soft, amp: 0.5 * am
  sleep 1
  sample :drum_bass_soft, amp: 0.5 * am
  #sleep 1
end

# ---- live loops

use_bpm get(:bpm)

live_loop :keys do
  ch = (sync :bar)[1]
  keys_chords_bar ch, 0.5
end

live_loop :bass do
  ch = (sync :bar)[1]
  bass_walking ch, 4, 1.25
end

live_loop :cymbals do
  sync :beat
  drums_cymbals_swing_sub_3_beat_4 sb = get(:sub_beat), 0.5
end

live_loop :drums do
  sync :bar
  drums_base_beat_4 0.5
end

# ---- start

cue :start

