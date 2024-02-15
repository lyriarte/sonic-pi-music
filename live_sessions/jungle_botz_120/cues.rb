# ---- cues

set :start_beats, nil
set :use_midi_chord, nil

# default midi synths
set :midi_synth, :dpulse
# use mod pulse synth if modulation range is non zero
set :midi_mod_synth, :mod_pulse


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
  :play_robot,           # C2
  :play_robot_rnd
]

# uncomment to disable play flags toggle with midi keyboard
#set :play_flags_keymap, nil

# auto play by movement, in sequence, random mode, otherwise manual
set :auto_play_mode, "movement" # , "sequence" , "random", nil

# seed the random to the current second
use_random_seed Time.new.sec
rand_reset

# jungle beat botz sounds 120 bpm random mode
define :jungle_botz_120_random do | br |
  # bass: change every 16 bars, 80% 
  if br % 16 == 0 then
    rnd = rrand(0,1)
    set :play_bass_octave, nil
    set :play_bass_root, nil
    set :play_bass_rnd, nil
    set :play_bass_octave, true if rnd.between?(0,0.4)
    set :play_bass_root, true if rnd.between?(0.4,0.6)
    set :play_bass_rnd, true if rnd.between?(0.6,0.8)
  end
  # cymbal: change every 24 bars, 95%
  if br % 24 == 0 then
    rnd = rrand(0,1)
    set :play_cymbal_beat, nil
    set :play_cymbal_sub, nil
    set :play_cymbal_beat, true if rnd.between?(0,0.35)
    set :play_cymbal_sub, true if rnd.between?(0.35,0.95)
  end
  # drums: change every 8 bars, 80%
  if br % 8 == 0 then
    rnd = rrand(0,1)
    set :play_drums_bass, nil
    set :play_drums_jungle, nil
    set :play_drums_bass, true if rnd.between?(0,0.2)
    set :play_drums_jungle, true if rnd.between?(0.2,0.8)
  end
  # keyboards change every 8 bars, 80%
  if br % 8 == 0 then
    rnd = rrand(0,1)
    set :play_chords_odd, nil
    set :play_chords_rnd_beat, nil
    set :play_chords_rnd_bar, nil
    set :play_chords_bar, nil
    set :play_chords_odd, true if rnd.between?(0,0.2)
    set :play_chords_rnd_beat, true if rnd.between?(0.2,0.4)
    set :play_chords_rnd_bar, true if rnd.between?(0.4,0.6)
    set :play_chords_bar, true if rnd.between?(0.6,0.8)
  end
  # sounds every 2 bars, 20% with overlap
  if br % 2 == 0 then
    rnd = rrand(0,1)
    set :play_chords_slide, nil
    set :play_robot, nil
    set :play_chords_slide, true if rnd.between?(0,0.175)
    set :play_robot, true if rnd.between?(0.15,0.2)
  end
  # low priority cue phase
  cue :phase, rrand_i(0,1) if rrand_i(0,32) == 0
end

set :movements_map, {
  "intro robot chords bar" => { "phase" => 0, "flags" => [:play_chords_bar, :play_drums_bass, :play_robot_rnd]},
  "open rnd bass hihat" => { "phase" => 0, "flags" => [:play_drums_bass, :play_robot_rnd, :play_bass_rnd, :play_cymbal_sub]},
  "open rnd bass keys slide" => { "phase" => 0, "flags" => [:play_chords_slide, :play_drums_bass, :play_robot_rnd, :play_bass_rnd, :play_cymbal_sub]},
  "open rnd bass odd keys" => { "phase" => 0, "flags" => [:play_chords_odd, :play_drums_bass, :play_robot_rnd, :play_bass_rnd, :play_cymbal_sub]},
  "octave bass" => { "phase" => 0, "flags" => [:play_chords_odd, :play_drums_bass, :play_robot_rnd, :play_bass_octave, :play_cymbal_sub]},
  "jungle rnd bass keys" => { "phase" => 0, "flags" => [:play_chords_rnd_beat, :play_drums_jungle, :play_robot_rnd, :play_bass_rnd, :play_cymbal_beat]},
  "jungle octave bass bridge rnd keys" => { "phase" => 1, "flags" => [:play_chords_rnd_bar, :play_drums_jungle, :play_robot_rnd, :play_bass_octave, :play_cymbal_beat]},
  "jungle octave bass bridge" => { "phase" => 1, "flags" => [:play_chords_rnd_bar, :play_robot_rnd, :play_bass_octave, :play_cymbal_beat]},
}

live_loop :cues do
  br, ch = (sync :bar)
  # toggle play flags according to total bars count if there is no keymap
  case get :auto_play_mode
  when "random"
    jungle_botz_120_random br
  when "movement"
    nb = (get :n_bar)
    if nb < 8
      cue :movement,   "intro robot chords bar"
    elsif nb < 24
      cue :movement,   "open rnd bass hihat"
    elsif nb < 32
      cue :movement,   "open rnd bass keys slide"
    elsif nb < 48
      cue :movement,   "open rnd bass odd keys"
    elsif nb < 52
      cue :movement,   "octave bass"
    elsif nb < 64
      cue :movement,   "jungle rnd bass keys"
    elsif nb < 80
      cue :movement,   "jungle octave bass bridge rnd keys"
    elsif nb < 88
      cue :movement,   "jungle octave bass bridge"
    else
      set :auto_play_mode, nil
    end
  end
end

cue :start
cue :movement,   "intro robot chords bar"

