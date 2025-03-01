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


define :play_dark_ambi_slide do | ch, nb=4, am=1, sy=:dark_ambience |
  with_synth sy do
    n0 = [ch[1], ch[2]].choose()
    n1 = ch[0]
    p0 = play n0, attack: 1, note_slide: nb, release: nb*2, decay: 2, amp: am/2
    control p0, note: n1
    sleep nb
  end
end

define :play_rnd_dbl do | ch, nb=4, am=1, sy=:chipbass |
  sb=4
  with_synth sy do
    nb.times do
      play ch.choose, attack: 0.02, release: 0.05, amp: am
      (2*sb - 1).times do
        sleep 1/Float(2*sb)
        play ch.choose, attack: 0.02, release: 0.05, amp: am/2, pan: (rrand -1, 1)
      end
      sleep 1/Float(2*sb)
    end
  end
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
    #play_kbd phases[movement["phase"]].tick(), nb=movement["beats"], am=0.5
    sleep(movement["beats"])
  end
  movement = movements_map["tense 4/4"]
  movement["mesures"].times do
    #play_kbd phases[movement["phase"]].tick(), nb=movement["beats"], am=1
    sleep(movement["beats"])
  end
  movement = movements_map["chord 4/4"]
  movement["mesures"].times do
    play_rnd_dbl phases[movement["phase"]].tick(), nb=movement["beats"], am=0.5
  end
  movement = movements_map["climax 4/4"]
  movement["mesures"].times do
    play_dark_ambi_slide phases[movement["phase"]].tick(), nb=movement["beats"], am=2
  end
  movement = movements_map["outro 5/4"]
  movement["mesures"].times do
    play_dark_ambi_slide phases[movement["phase"]].tick(), nb=movement["beats"], am=4
  end
  sync :done
end

live_loop :hh do
  intro_beats.times do
    sample :drum_cymbal_closed
    sleep 1
  end
  sync :done
end







