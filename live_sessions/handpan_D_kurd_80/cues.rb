
live_loop :cues do
  br, ch = (sync :bar)
  # toggle play flags according to total bars count if there is no keymap
  case get :auto_play_mode
  when "movement"
    nb = (get :n_bar)
    if nb < 8
      cue :movement, "ambient"
    elsif nb < 40
      cue :movement, "pulse"
    elsif nb < 56
      cue :movement, "bridge"
    else
      cue :movement, "house"
    end
  end
end

cue :start
cue :movement, "ambient"


