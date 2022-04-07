# Summertime

set :bpm, 140
set :beats, 3
set :sub_beat, 2

set :start_beats, true

set :chords, [
  (chord :D, :minor7),  (chord :A, :dom7),
  (chord :D, :minor7),  (chord :A, :dom7),
  (chord :D, :minor7),  (chord :A, :dom7),
  (chord :D, :minor7),  (chord :A, :dom7),
  
  (chord :G, :minor7),  (chord :C, :dom7),
  (chord :G, :minor7),  (chord :C, :dom7),
  (chord :E, :dim7),    (chord :E, :dim7),
  (chord :A, :dom7),    (chord :A, :dom7),
  
  (chord :D, :minor7),  (chord :A, :dom7),
  (chord :D, :minor7),  (chord :A, :dom7),
  (chord :D, :minor7),  (chord :A, :dom7),
  (chord :D, :minor7),  (chord :A, :dom7),
  
  (chord :F, :major7),  (chord :Bb, :major),
  (chord :E, :dim7),    (chord :A, :dom7),
  (chord :D, :minor7),  (chord :D, :minor7),
  (chord :E, :dim7),    (chord :A, :dom7)
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

# hi hat on sub beat
define :drums_cymbals_sub_beat do | sb=4, am=1|
  sample :drum_cymbal_closed, amp: 0.5 * am
  (sb - 1).times do
    sleep 1/Float(sb)
    sample :drum_cymbal_closed, amp: 0.25 * am
  end
  #sleep 1/sb
end


# ---- live loops

use_bpm get(:bpm)

live_loop :keys do
  ch = (sync :bar)[1]
  keys_chords_bar ch, nb = get(:beats), 0.5
end

live_loop :bass do
  ch = (sync :bar)[1]
  bass_walking ch, nb = get(:beats), 1.25
end

live_loop :cymbals do
  sync :beat
  drums_cymbals_sub_beat sb = get(:sub_beat), 0.5
end

live_loop :drums do
  sync :bar
  sample :drum_bass_soft
end


# ---- cues

#cue :start

