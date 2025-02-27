# 5/4 |  Dm  | Bb7M |  Bb  |  C7  |

# 4/4 |  Am  |   %  |   %  |   %  |

# 4/4 |  Am  |   %  |   C  |   %  |
#     |   F  |   %  |  Em  |  Bb  |

use_bpm 145

phases = [
  [
    (chord :D, :minor),  (chord :Bb,:major7),
    (chord :Bb,:major),  (chord :C, :dom7)
  ].ring,
  (
    [(chord :A, :minor)] * 4
  ).ring,
  [
    (chord :A, :minor),  (chord :A, :minor),
    (chord :C, :major),  (chord :C, :major),
    (chord :F, :major),  (chord :F, :major),
    (chord :E, :minor),  (chord :Bb,:major)
  ].ring
]

define :play_kbd do | ch, nb=4, am=1 |
  play ch, release: nb, amp: am
  sleep nb
end

live_loop :chords do
  use_synth :tb303
  sleep 10
  (16*4).times do
    play_kbd phases[0].tick(), nb=5, am=0.5
  end
  (1*8).times do
    play_kbd phases[1].tick(), nb=4, am=1
  end
  (8*4).times do
    play_kbd phases[2].tick(), nb=2, am=0.5
  end
  (3*8).times do
    play_kbd phases[1].tick(), nb=4, am=0.5
  end
  (4*4).times do
    play_kbd phases[0].tick(), nb=5, am=0.2
  end
  sync :done
end

live_loop :hh do
  (10+16*4*5+1*8*4+8*4*2+3*8*4+4*4*5).times do
    sample :drum_cymbal_closed
    sleep 1
  end
  sync :done
end







