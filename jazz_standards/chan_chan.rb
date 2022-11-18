# Chan Chan

set :bpm, 80
set :beats, 2
set :sub_beat, 4

set :start_beats, true

set :chords, [
  (chord :D5, :minor7),  (chord :F5, :major),
  (chord :G, :minor7),  (chord :A, :dom7),
  
  (chord :D5, :minor7),  (chord :F, :major),
  (chord :G, :minor7),  (chord :A, :dom7)
  
].ring


# ---- live loops

use_bpm get(:bpm)

live_loop :keys do
  br, ch = (sync :bar)
  if br % 2 == 0 then
    play ch, release: 1
    with_octave -2 do
      play ch[0], release: 0.2
    end
    sleep 1.5
    ch = (get :chords)[br+1]
    play ch, release: 2
    with_octave -2 do
      play ch[0], release: 0.2
    end
  end
end

# ---- cues

#cue :start
