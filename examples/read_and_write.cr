require "../src/tui"
Tui.init
Tui.echo

win1_dimension = Tui::Dimension.new(0,0,40,40)
win2_dimension = Tui::Dimension.new(40,0,40,40)
win3_dimension = Tui::Dimension.new(0,40,5,80)
Tui.add_win("left", win1_dimension)
Tui.add_win("right", win2_dimension)
Tui.add_win("bottom", win3_dimension)


spawn do
  loop do
    win = Tui.windows.last
    win.read(1)
    win.print_buffer
    Tui.windows[0].print(win.string_buffer)
    Tui.windows[1].print(win.string_buffer)
  end
end

Tui.main_loop
