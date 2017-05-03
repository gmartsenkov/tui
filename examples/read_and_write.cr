Tui.init
Tui.noecho

win1_dimension = Tui::Dimension.new(0,0,40,40)
win2_dimension = Tui::Dimension.new(40,0,40,40)
Tui.add_win("left", win1_dimension)
Tui.add_win("right", win2_dimension)

spawn do
  Tui.windows.first.tap do |win|
    win.print("bla")
    win.print("blak")
  end
  Tui.windows.last.tap do |win|
    win.read
    win.print_buffer
  end
end
Tui.main_loop
