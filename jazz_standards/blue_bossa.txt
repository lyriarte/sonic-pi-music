# Blue bossa

set :bpm, 160
set :beats, 4
set :sub_beat, 2

set :chords, [
  (chord :C, :minor7),  (chord :C, :minor7),
  (chord :F, :minor7),  (chord :F, :minor7),
  
  (chord :D, :dim7),    (chord :G, :dom7),
  (chord :C, :minor7),  (chord :C, :minor7),
  
  (chord :Eb, :minor7), (chord :Ab, :dom7),
  (chord :Db, :major7), (chord :Db, :major7),
  
  (chord :D, :dim7),    (chord :G, :dom7),
  (chord :C, :minor7),  (chord :G, :dom7)
].ring


# ---- instruments

# one chord per bar
define :keys_chords_bar do | ch, nb=4, am=1, sy=:blade |
  use_synth sy
  play ch, amp: am, release: nb
end

# latin bass, 4 beats per bar
define :bass_latin_beat_4 do | ch, am=1, sy=:subpulse |
  use_synth sy
  use_octave -2
  play ch[0], release:0.2, amp: 2 * am
  sleep 1.5
  play ch[2], release:0.2, amp: am
  sleep 0.5
  play ch[2], release:0.2, amp: am
  sleep 1.5
  play ch[2], release:0.2, amp: am
  #sleep 0.5
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

# ---- live loops

use_bpm get(:bpm)

live_loop :keys do
  ch = (sync :bar)[1]
  keys_chords_bar ch, 0.5
end

live_loop :bass do
  ch = (sync :bar)[1]
  bass_latin_beat_4 ch, 1.25
end

live_loop :cymbals do
  sync :beat
  drums_cymbals_sub_beat sb = get(:sub_beat)
end

live_loop :drums do
  sync :bar
  drums_binary_beat_4 0.25
end

# ---- start

cue :start

