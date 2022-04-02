#  jungle beat botz sounds 120 bpm setup

# https://soundcloud.com/m_u_l_e/junglebotz-120-20220322

set :bpm, 120
set :beats, 4
set :sub_beat, 4


set :phases, [
  [
    (chord :E, :minor7),  (chord :E, :minor7),
    (chord :G3, :maj),  (chord :A3, :dom7)
  ].ring,
  [
    (chord :B, :minor7),  (chord :B, :minor7)
  ].ring
]
set :chords, (get :phases)[0]

