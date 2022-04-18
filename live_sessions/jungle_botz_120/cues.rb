# ---- cues

set :start_beats, nil
set :use_midi_chord, nil

# keymap to toggle play flags with midi keyboard lower notes
set :play_flags_keymap, [
  :play_bass_octave,     # C1
  :play_bass_root,
  :play_bass_rnd,        # D1
  :play_cymbal_beat,     
  :play_cymbal_sub,      # E1
  :play_drums_bass,      # F1
  :play_drums_jungle,
  :play_chords_odd,      # G1
  :play_chords_rnd_beat, 
  :play_chords_rnd_bar,  # A1
  :play_chords_bar,     
  :play_chords_slide,    # B1
  :play_robot            # C2
]

cue :phase, 0
cue :start
