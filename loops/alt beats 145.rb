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

movements_map = {
  "intro 5/4" => { "phase" => 0, "beats" => 5, "mesures" => (16*4)},
  "tense 4/4"  => { "phase" => 1, "beats" => 4, "mesures" => (2*4)},
  "chord 4/4"  => { "phase" => 2, "beats" => 2, "mesures" => (8*4)},
  "climax 4/4"  => { "phase" => 1, "beats" => 4, "mesures" => (6*4)},
  "outro 5/4"  => { "phase" => 0, "beats" => 5, "mesures" => (4*4)},
}

intro_beats = 10

total_beats = intro_beats
movements_map.each do | k, v |
  total_beats = total_beats + v["mesures"] * v["beats"]
end


live_loop :chords do
  use_synth :tb303
  sleep intro_beats
  movement = movements_map["intro 5/4"]
  movement["mesures"].times do
    play_kbd phases[movement["phase"]].tick(), nb=movement["beats"], am=0.5
  end
  movement = movements_map["tense 4/4"]
  movement["mesures"].times do
    play_kbd phases[movement["phase"]].tick(), nb=movement["beats"], am=1
  end
  movement = movements_map["chord 4/4"]
  movement["mesures"].times do
    play_kbd phases[movement["phase"]].tick(), nb=movement["beats"], am=0.5
  end
  movement = movements_map["climax 4/4"]
  movement["mesures"].times do
    play_kbd phases[movement["phase"]].tick(), nb=movement["beats"], am=0.5
  end
  movement = movements_map["outro 5/4"]
  movement["mesures"].times do
    play_kbd phases[movement["phase"]].tick(), nb=movement["beats"], am=0.2
  end
  sync :done
end

live_loop :hh do
  total_beats.times do
    sample :drum_cymbal_closed
    sleep 1
  end
  sync :done
end







