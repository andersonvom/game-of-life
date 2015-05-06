function tick()
{
  Processing.getInstanceById('game').tick();
}

function play()
{
  Processing.getInstanceById('game').play();
}

function stop()
{
  Processing.getInstanceById('game').stop();
}

function rand()
{
  Processing.getInstanceById('game').rand();
}

function cls()
{
  Processing.getInstanceById('game').clear();
}

function speed(spd)
{
  Processing.getInstanceById('game').speed(spd);
}

function size(x, y)
{
  Processing.getInstanceById('game').reset_board(x, y);
}

function center()
{
  Processing.getInstanceById('game').center();
}

function save()
{
  Processing.getInstanceById('game').save();
}

function restart()
{
  Processing.getInstanceById('game').restart();
}

function bench()
{
  var time = 0;
  for (var j=0; j<10; j++)
  {
    var board = new Board();
    board.init(200,200);
    board.randomize();
    var s = new Date();
    for (var i=0; i<100; i++) { board.tick(); }
    var e = new Date();
    time += e.getTime() - s.getTime();
  }
  alert(time/10);
}

/*
Object.prototype.clone = function() {
  var newObj = (this instanceof Array) ? [] : {};
  for (i in this) {
    if (i == 'clone') continue;
    if (this[i] && typeof this[i] == "object") {
      newObj[i] = this[i].clone();
    } else newObj[i] = this[i]
  } return newObj;
};
*/
