# ---- cues

set :start_beats, nil
set :use_midi_chord, nil

# default midi synths
set :midi_synth, :pretty_bell
# use mod triangle wave synth if modulation range is non zero
set :midi_mod_synth, :mod_tri

# keymap to toggle play flags with midi keyboard lower notes
set :play_flags_keymap, [
  :play_bass_octave,     # C1
  :play_bass_base,
  :play_cymbal_beat,     # D1
  :play_cymbal_sub,
  :play_drums_house,     # E1
  :play_chords_odd,      # F1
  :play_chords_rnd,
  :play_chords_beat,     # G1
  :play_bells_rnd,
  :play_chords_rnd_beat, # A1
  :play_haunted,
  :play_ambient          # B1
]

# uncomment to disable play flags toggle with midi keyboard
#set :play_flags_keymap, nil

# auto play by movement, in sequence, random mode, otherwise manual
set :auto_play_mode, "movement" # , "sequence" , "random", nil

# seed the random to the current second
use_random_seed Time.new.sec
rand_reset

# bridge phases ambient 100 bpm default sequence
define :bridge_phases_ambient_100_sequence do | n_bar |
  set :play_bass_octave, nil
  set :play_bass_octave, true if n_bar.between?(16,31)
  set :play_bass_base, nil
  set :play_bass_base, true if n_bar < 16 or n_bar >= 64
  set :play_cymbal_beat, nil
  set :play_cymbal_beat, true if n_bar < 24
  set :play_cymbal_sub, nil
  set :play_cymbal_sub, true if n_bar >= 24
  set :play_drums_house, nil
  set :play_drums_house, true if n_bar >= 28
  set :play_chords_odd, nil
  set :play_chords_odd, true if n_bar.between?(20,63)
  set :play_chords_rnd, nil
  set :play_chords_rnd, true if n_bar.between?(48,63) and one_in 2
  set :play_chords_beat, nil
  set :play_chords_beat, true if n_bar < 32
  set :play_bells_rnd, nil
  set :play_bells_rnd, true if n_bar.between?(72,95)
  set :play_chords_rnd_beat, nil
  set :play_chords_rnd_beat, true if n_bar.between?(16,31)
  set :play_haunted, nil
  set :play_haunted, true if n_bar >= 84
  set :play_ambient, nil
  set :play_ambient, true if n_bar.between?(68,80)
  cue :phase, 1 if n_bar == 62
end


# bridge phases ambient 100 bpm random mode
define :bridge_phases_ambient_100_random do | br |
  # bass: change every 16 bars, 80% even among 2
  if br % 16 == 0 then
    rnd = rrand(0,1)
    set :play_bass_octave, nil
    set :play_bass_base, nil
    set :play_bass_octave, true if rnd.between?(0,0.4)
    set :play_bass_base, true if rnd.between?(0.4,0.8)
  end
  # cymbal: change every 24 bars, 95% - beat 60% double 35%
  if br % 24 == 0 then
    rnd = rrand(0,1)
    set :play_cymbal_beat, nil
    set :play_cymbal_sub, nil
    set :play_cymbal_beat, true if rnd.between?(0,0.6)
    set :play_cymbal_sub, true if rnd.between?(0.6,0.95)
  end
  # drums: change every 4 bars, 80%
  if br % 4 == 0 then
    set :play_drums_house, nil
    set :play_drums_house, true if rrand(0,1) < 0.80
  end
  # keyboards change every 8 bars, 80%
  if br % 8 == 0 then
    rnd = rrand(0,1)
    set :play_chords_beat, nil
    set :play_chords_odd, nil
    set :play_chords_rnd, nil
    set :play_chords_rnd_beat, nil
    set :play_chords_beat, true if rnd.between?(0,0.2)
    set :play_chords_odd, true if rnd.between?(0.2,0.6)
    set :play_chords_rnd, true if rnd.between?(0.6,0.75)
    set :play_chords_rnd_beat, true if rnd.between?(0.75,0.8)
  end
  # sounds every 4 bars, 30% with overlap
  if br % 4 == 0 then
    rnd = rrand(0,1)
    set :play_bells_rnd, nil
    set :play_ambient, nil
    set :play_haunted, nil
    set :play_bells_rnd, true if rnd.between?(0.1,0.2)
    set :play_haunted, true if rnd.between?(0,0.2)
    set :play_ambient, true if rnd.between?(0.1,0.3)
  end
  # low priority cue phase
  cue :phase, rrand_i(0,1) if rrand_i(0,32) == 0
end

# bridge phases ambient 100 bpm movements
define :bridge_phases_ambient_100_movements do | movement |
  for flag in (get :play_flags_keymap) do
    set flag, false
  end
  case movement
  when "intro"
    set :play_bass_base, true
    set :play_chords_beat, true
    set :play_cymbal_beat, true
    cue :phase, 0
  when "octave rnd beat"
    set :play_bass_octave, true
    set :play_chords_beat, true
    set :play_cymbal_beat, true
    set :play_chords_rnd_beat, true
    cue :phase, 0
  when "octave double"
    set :play_bass_octave, true
    set :play_chords_odd, true
    set :play_cymbal_sub, true
    cue :phase, 0
  when "octave house"
    set :play_bass_octave, true
    set :play_chords_odd, true
    set :play_cymbal_sub, true
    set :play_drums_house, true
    cue :phase, 0
  when "bridge beat rnd house"
    set :play_bass_base, true
    set :play_chords_beat, true
    set :play_cymbal_beat, true
    set :play_drums_house, true
    set :play_chords_rnd, true
    cue :phase, 1
  when "ambient bells base"
    set :play_bass_base, true
    set :play_chords_beat, true
    set :play_cymbal_beat, true
    set :play_ambient, true
    set :play_bells_rnd, true
    cue :phase, 1
  when "haunted bells base"
    set :play_haunted, true
    set :play_bells_rnd, true
    cue :phase, 1
  end
end

live_loop :cues do
  br, ch = (sync :bar)
  # toggle play flags according to total bars count if there is no keymap
  case get :auto_play_mode
  when "sequence"
    bridge_phases_ambient_100_sequence (get :n_bar)
  when "random"
    bridge_phases_ambient_100_random br
  when "movement"
    nb = (get :n_bar)
    if nb < 16
      bridge_phases_ambient_100_movements "intro"
    elsif nb < 24
      bridge_phases_ambient_100_movements "octave rnd beat"
    elsif nb < 28
      bridge_phases_ambient_100_movements "octave double"
    elsif nb < 32
      bridge_phases_ambient_100_movements "octave house"
    elsif nb < 48
      bridge_phases_ambient_100_movements "bridge beat rnd house"
    elsif nb < 64
      bridge_phases_ambient_100_movements "ambient bells base"
    elsif nb < 72
      bridge_phases_ambient_100_movements "haunted bells base"
    else 
      set :auto_play_mode, nil
    end
  end
end

bridge_phases_ambient_100_movements "intro"
cue :start

