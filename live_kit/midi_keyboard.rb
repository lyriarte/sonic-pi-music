#  ---- ----  ----  ---- midi keyboard input


# ---- midi synth default to beep synth

set :midi_synth, :mod_beep
set :midi_amp, 1
ct_amp = 7
range_amp = [0,4]
set :midi_attack, 0
ct_attack = 74
range_attack = [0,2]
set :midi_decay, 0
ct_decay = 71
range_decay = [0,4]
set :midi_sustain, 0
ct_sustain = 73
range_sustain = [0,4]
set :midi_release, 1
ct_release = 72
range_release = [0.2,8]
set :midi_mod_range, 0
ct_mod_range = 1
range_mod_range = [0,12]
set :midi_mod_phase, 0.25


# ---- midi chord

set :midi_chrd, []

define :play_midi_chord do | ch |
  play ch, amp: (get :midi_amp), 
    attack: (get :midi_attack), 
    decay: (get :midi_decay), 
    sustain: (get :midi_sustain), 
    release: (get :midi_release),
    mod_range: (get :midi_mod_range),
    mod_phase: (get :midi_mod_phase)
end


# ---- midi event capture

live_loop :midi_note_on do
  use_real_time
  use_synth (get :midi_synth)
  # sync keydown event
  nt, vl = sync "/midi:midi_through_port-0:0:1/note_on"
  # if lower notes are used as flags in a keymap 
  if (get :play_flags_keymap) and nt < (get :play_flags_keymap).length() then
    # toggle flag in the keymap indexed by the midi note
    set (get :play_flags_keymap)[nt], (not get (get :play_flags_keymap)[nt])
  # otherwise add the note to the global midi chord
  else
    ch = (get :midi_chrd).dup
    ch.append(nt)
    set :midi_chrd, ch
    # if overriding chord progression, set midi chord as current chord
    if get :use_midi_chord
      set :chrd, ch
    # otherwise play midi chord
    else
      play_midi_chord ch
    end
  end
end

live_loop :midi_note_off do
  use_real_time
  # sync keyup event
  nt, vl = sync "/midi:midi_through_port-0:0:1/note_off"
  # remove note from the current midi chord
  ch = (get :midi_chrd).dup
  ch.delete(nt)
  set :midi_chrd, ch
end


define :control_ponderation do | rg, va |
  return rg[0] + (va / Float(127)) * (rg[1] - rg[0])
end

live_loop :midi_control_change do
  use_real_time
  # sync ctrl event
  ct, va = sync "/midi:midi_through_port-0:0:1/control_change"
  case ct
  when ct_amp
    set :midi_amp, (control_ponderation range_amp, va)
  when ct_attack
    set :midi_attack, (control_ponderation range_attack, va)
  when ct_decay
    set :midi_decay, (control_ponderation range_decay, va)
  when ct_sustain
    set :midi_sustain, (control_ponderation range_sustain, va)
  when ct_release
    set :midi_release, (control_ponderation range_release, va)
  when ct_mod_range
    set :midi_mod_range, Integer(control_ponderation range_mod_range, va)
  end
end
