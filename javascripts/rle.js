function RLE()
{
  this.encoding = "";
  
  this.decode = function(encoding)
  {
    var stream = [];
    var lines = encoding.split('\n');
    
    for (var i in lines)
    {
      var line = lines[i].replace(/ /gi, '');
      
      // Ignore comments
      if (line.charAt(0) == '#') continue;
      
      // TODO: Parse size and rules. Now what?
      else if (line.charAt(0) == 'x')
      {
        line = line.replace('x=', '');
        line = line.replace('y=', '');
        var size = line.split(',', 2);
      }
      
      // Parse RLE
      else {
        stream = stream.concat(this.parse_line(line));
      }
      
    }
    
    return stream;
  }
  
  this.parse_line = function(line)
  {
    var states = [];
    var items = line.match(/([0-9]*(b|o)|[$!])/g);
    
    for (var i in items)
    {
      var item = items[i];
      if (item.length == 1) {
        states.push(item);
      }
      else {
        var state = item.charAt(item.length-1);
        var count = parseInt(item);
        while (count > 0) { states.push(state); count--; }
      }
    }
    
    return states;
  }
  
  this.encode = function(board_states)
  {
    var stream = [];
    
    // Remove dead cell in the end of the line and split the rest
    for (var i in board_states) {
      var line = board_states[i].replace(/b*$/, '$');
      stream = stream.concat(line.match(/(b+|o+|\$)/g));
    }
    
    // Add final End of Line symbol
    var last_item = stream.pop();
    if (last_item != "$") stream.push(last_item);
    stream.push('!');
    
    // Count all else
    var encoding = [];
    for (var i in stream) {
      var length = stream[i].length;
      if (length == 1) length = "";
      encoding.push( length + stream[i].charAt(0) );
    }
    
    return encoding.join('').replace(/\$+!/, '!');
  }
  
}
