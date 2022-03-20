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
set :midi_hold, false

define :play_midi_chord do | ch |
  play ch, amp: (get :midi_amp), 
    attack: (get :midi_attack), 
    decay: (get :midi_decay), 
    sustain: (get :midi_sustain), 
    release: (get :midi_release)
end

live_loop :midi_chord_loop do
  use_real_time
  use_synth (get :midi_synth)
  ch, on = sync :midi_changed
  set :chrd, ch if get :use_midi_chord
  play_midi_chord ch if get :midi_hold
end


# ---- midi event capture

live_loop :midi_note_on do
  use_real_time
  nt, vl = sync "/midi:midi_through_port-0:0:1/note_on"
  ch = (get :midi_chrd).dup
  ch.append(nt)
  set :midi_chrd, ch
  if get :use_midi_chord
    set :chrd, ch
  else
    play_midi_chord ch
  end
  if get :midi_hold
    cue :midi_changed, ch, true
  end
end

live_loop :midi_note_off do
  use_real_time
  nt, vl = sync "/midi:midi_through_port-0:0:1/note_off"
  ch = (get :midi_chrd).dup
  ch.delete(nt)
  set :midi_chrd, ch
  cue :midi_changed, ch, false
end
