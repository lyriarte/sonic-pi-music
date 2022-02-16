# https://soundcloud.com/m_u_l_e/rock120-shuffle-loop
# Em7 |  D  |  A7 |  A7 |

use_bpm 120

live_loop :bass do
  use_synth :chipbass
  8.times do
    play choose(chord(:e2, :minor7)), amp: 2
    sleep 0.5
  end
  8.times do
    play choose(chord(:d2, :major)), amp: 2
    sleep 0.5
  end
  16.times do
    play choose(chord(:a1, :"7")), amp: 2
    sleep 0.5
  end
end

live_loop :chords do
  use_synth :tb303
  play chord(:e4, :minor7), attack: 1, release: 3, amp: 0.5
  sleep 4
  play chord(:d4, :major), attack: 1, release: 3, amp: 0.5
  sleep 4
  play chord(:a3, :"7"), attack: 1, release: 5, amp: 0.5
  sleep 8
end




# Jungle beat

use_bpm 120

live_loop :hh_16 do
  4.times do
    sample :drum_cymbal_closed
    sleep 0.25
  end
  sample :drum_cymbal_open, attack: 0.1, finish: 0.15
  sleep 0.25
  3.times do
    sample :drum_cymbal_closed
    sleep 0.25
  end
end


live_loop :jungle_beat do
  sample :drum_bass_hard
  sleep 0.5
  sample :drum_bass_hard
  sleep 0.5
  sample :drum_snare_hard
  sleep 0.5
  sample :drum_bass_hard
  sleep 0.25
  sample :drum_snare_hard
  sleep 0.25
  sample :drum_bass_hard
  sleep 0.25
  sample :drum_snare_hard
  sleep 0.25
  sample :drum_bass_hard
  sleep 0.5
  sample :drum_snare_hard
  sleep 1.0
end
