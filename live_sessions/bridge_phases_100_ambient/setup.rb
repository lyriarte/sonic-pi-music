#  bridge phases ambient 100 bpm setup

# https://soundcloud.com/m_u_l_e/ambient-100-20220322

set :bpm, 100
set :beats, 4
set :sub_beat, 4


base_chords = [
  (chord :D, :minor7),  (chord :D, :minor7),
  (chord :E, :minor7),  (chord :E, :minor7)
].ring

bridge_chords = [
  (chord :Fs, :minor7),  (chord :E, :minor7),
  (chord :B3, :minor7),  (chord :B3, :minor7)
].ring

set :phases, [base_chords, bridge_chords]
set :chords, (get :phases)[0]
