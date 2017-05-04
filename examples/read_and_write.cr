require "../src/tui"
Tui.init
Tui.echo

win1_dimension = Tui::Dimension.new(0,0,40,40)
win2_dimension = Tui::Dimension.new(40,0,40,40)
Tui.add_win("left", win1_dimension)
Tui.add_win("right", win2_dimension)

spawn do
  Tui.windows.first.tap do |win|
    x = 1
    loop do
      sleep 1
      x += 1
      win.print("bla-#{x}")
    end
  end
end

spawn do
  Tui.windows.last.tap do |win|
    loop do
      sleep 1
      win.read(1)
      win.print_buffer
    end
  end
end
Tui.main_loop
