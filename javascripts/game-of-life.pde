spacing = 0;
tile_width = 8;
length = tile_width + spacing;
num_tiles = [50, 50];
canvas_size = [ num_tiles[0]*length+spacing+1, num_tiles[1]*length+spacing+1 ];
background_color = 200;
mouse_start_col = 0;
mouse_start_row = 0;
start_status = false;
board = new Board();
starting_hash = "";

void setup()
{
  size(canvas_size[0], canvas_size[1]);
  fill(255);
  stroke(background_color);
  background(background_color);
  board.init(num_tiles[0],num_tiles[1]);
  board.fill_cells(0);
  decode_hash();
    
  window.addEventListener("hashchange", decode_hash, false);
}

void decode_hash()
{
  starting_hash = getBoardEncoding();
  board.rle_decode( starting_hash );
}

void reset_board(columns, rows)
{
  num_tiles = [columns, rows];
  canvas_size = [ num_tiles[0]*length+spacing+1, num_tiles[1]*length+spacing+1 ];
  setup();
}

void draw()
{
  var changed_positions = board.flush_changed_cells();
  if (changed_positions.length > 0)
  {
    for (var i=0; i<changed_positions.length; i++) {
      var pos = changed_positions[i];
      draw_cell(pos[0], pos[1]);
    }
  }
}

void draw_cell(row, col)
{
  var cells = board.get_cells();
  var cell = cells[row][col];
  
  if (cell.is_alive()) fill(255,0,0);
  else fill(255);
  
  x_position = length*(col-1) + spacing;
  y_position = length*(row-1) + spacing;
  rect(x_position, y_position, tile_width, tile_width);
}

void mouseClicked()
{
  var row = position(mouseY);
  var col = position(mouseX);
  board.toggle_cell(row, col);
  updateURL();
}

void mousePressed()
{
  var cells = board.get_cells();
  mouse_start_row = position(mouseY);
  mouse_start_col = position(mouseX);
  start_status = cells[mouse_start_row][mouse_start_col].is_alive()
}

void mouseReleased()
{
  updateURL();
}

void mouseOut()
{
  updateURL();
}

void mouseDragged()
{
  var row = position(mouseY);
  var col = position(mouseX);
  var cells = board.get_cells();
  if (!start_status) {
    if (!cells[row][col].is_alive())
      board.toggle_cell(row,col);
  }
  else {
    if (cells[row][col].is_alive())
      board.toggle_cell(row,col);
  }
}

int position(mouse_position)
{
  // +1 For padding
  return (int)((mouse_position - 1) / length) + 1;
}

void keyPressed()
{
  if (key == 'r') {
    rand();
  }
  else if (key == 'c') {
    clear();
  }
  else if (key == 's') {
    stop();
  }
  else if (key == 'p') {
    play();
  }
  else if (key == 't') {
    tick();
  }
  else if (key == '+') {
    speed(0.2);
  }
  else if (key == '-') {
    speed(-0.2);
  }
}

void updateURL()
{
  window.location.hash = board.rle_encode();
}

String getBoardEncoding()
{
  return window.location.hash.substring(1);
}

void rand()  { board.randomize(); updateURL(); }
void clear() { board.change_speed(0); board.fill_cells(0); updateURL(); }
void stop()  { board.stop(); updateURL(); }
void play()  { board.run(); }
void tick()  { board.tick(); updateURL(); }
void speed(spd) { board.change_speed(spd); }
void center()  { board.center(); updateURL(); }
void restart() { board.rle_decode( starting_hash ); updateURL(); }

