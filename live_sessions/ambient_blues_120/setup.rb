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
      (chord :G, :minor7), (chord :F, :minor7), (chord :Bb, :maj), (chord :C, :minor7),
      (chord :G, :minor7), (chord :F, :minor7), (chord :Bb, :maj), (chord :Bb, :maj)
    ]
  ).ring
]
set :chords, (get :phases)[0]

