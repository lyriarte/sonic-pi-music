#  jungle beat botz sounds 120 bpm setup

set :bpm, 120
set :beats, 4
set :sub_beat, 4


set :phases, [
  [(chord :E, :maj),  (chord :E, :dom7)].ring
]
set :chords, (get :phases)[0]
