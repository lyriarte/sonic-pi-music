#  ---- ----  ----  ---- midi keyboard input

# ---- midi chord

set :midi_chrd, []
set :midi_hold, false
# default to beep synth
set :midi_synth, :beep
set :midi_amp, 1
set :midi_attack, 0
set :midi_decay, 0
set :midi_sustain, 0
set :midi_release, 1



live_loop :play_midi_chord do
  use_synth (get :midi_synth)
  ch, on = sync :midi_changed
  if on or (get :midi_hold)
    play ch, amp: (get :midi_amp), 
      attack: (get :midi_attack), 
      decay: (get :midi_decay), 
      sustain: (get :midi_sustain), 
      release: (get :midi_release)
  end
end


# ---- midi event capture

live_loop :midi_note_on do
  nt, vl = sync "/midi:midi_through_port-0:0:1/note_on"
  ch = (get :midi_chrd).dup
  ch.append(nt)
  set :midi_chrd, ch
  cue :midi_changed, ch, true
end

live_loop :midi_note_off do
  nt, vl = sync "/midi:midi_through_port-0:0:1/note_off"
  ch = (get :midi_chrd).dup
  ch.delete(nt)
  set :midi_chrd, ch
  cue :midi_changed, ch, false
end
