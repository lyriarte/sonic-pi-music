#  ---- ----  ----  ---- midi keyboard input


# ---- midi synth default to beep synth

set :midi_synth, :beep
set :midi_amp, 1
set :midi_attack, 0
set :midi_decay, 0
set :midi_sustain, 0
set :midi_release, 1


# ---- midi chord

set :midi_chrd, []

define :play_midi_chord do | ch |
  play ch, amp: (get :midi_amp), 
    attack: (get :midi_attack), 
    decay: (get :midi_decay), 
    sustain: (get :midi_sustain), 
    release: (get :midi_release)
end


# ---- midi event capture

live_loop :midi_note_on do
  use_real_time
  use_synth (get :midi_synth)
  nt, vl = sync "/midi:midi_through_port-0:0:1/note_on"
  if (get :play_flags_keymap) and nt < (get :play_flags_keymap).length() then
    set (get :play_flags_keymap)[nt], (not get (get :play_flags_keymap)[nt])
  else
    ch = (get :midi_chrd).dup
    ch.append(nt)
    set :midi_chrd, ch
    if get :use_midi_chord
      set :chrd, ch
    else
      play_midi_chord ch
    end
  end
end

live_loop :midi_note_off do
  use_real_time
  nt, vl = sync "/midi:midi_through_port-0:0:1/note_off"
  ch = (get :midi_chrd).dup
  ch.delete(nt)
  set :midi_chrd, ch
end
