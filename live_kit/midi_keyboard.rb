#  ---- ----  ----  ---- midi keyboard input

# ---- midi chord

set :midi_chrd, []

live_loop :play_midi_chord do
  ch, on = sync :midi_changed
  play_chord ch if on
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
