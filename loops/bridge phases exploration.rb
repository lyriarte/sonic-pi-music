#  bridge phases exploration

set :bpm, 100
set :beats, 4
set :sub_beat, 4


base_chords = [
  (chord :D, :minor7),  (chord :D, :minor7),
  (chord :E, :minor7),  (chord :E, :minor7)
]

bridge_chords = [
  (chord :Fs, :minor7),  (chord :E, :minor7),
  (chord :B3, :minor7),  (chord :B3, :minor7)
]

set :phases, [base_chords, bridge_chords]
set :chords, (get :phases)[0]

# ---- live loops

use_bpm get(:bpm)

live_loop :keys do
  br, ch = (sync :bar)
  play ch
end

live_loop :bass do
  br, ch = (sync :bar)
  use_octave -2
  play ch[0]
  sleep 1.5
  play ch[0]
  sleep 0.5
  play ch[0]
end

live_loop :cymbals do
  bt = sync :beat
  sample :drum_cymbal_closed, amp: 0.5
end

live_loop :drums do
  sync :bar
end

# ---- start

cue :start

