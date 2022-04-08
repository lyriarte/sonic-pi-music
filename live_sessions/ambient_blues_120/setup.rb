#  ambient house 120 bpm setup

set :bpm, 120
set :beats, 4
set :sub_beat, 4


set :phases, [
  (
    [(chord :C, :minor7)] * 4 + 
    [(chord :F, :minor7)] * 2 + 
    [(chord :C, :minor7)] * 2 + 
    [
      (chord :G3, :minor7), (chord :F3, :minor7), (chord :Bb3, :maj), (chord :C, :minor7),
      (chord :G3, :minor7), (chord :F3, :minor7), (chord :Bb3, :maj), (chord :Bb3, :maj)
    ]
  ).ring
]
set :chords, (get :phases)[0]

