var fs  = require("fs");

var MinesweeperMaster = function(r, c, m) {
  this.r = r;
  this.c = c;
  this.m = m;
  this.board = [];
  this.answer = [];
}
MinesweeperMaster.prototype.initBoard = function() {
  this.board = [];
  for(var y = 0; y < this.r; y++) {
    this.board.push([]);
    for(var x = 0; x < this.c; x++) {
      this.board[y].push(".");
    }
  }
}
MinesweeperMaster.prototype.setMines = function() {
  if (this.m < 1) {
    return;
  }
  var odd = this.m % this.c;
  var fullColumnCount = Math.floor(this.m / this.c);

  // 上から詰める
  var m = this.m;
  for(var y = 0; y < this.r; y++) {
    for(var x = 0; x < this.c; x++) {
      if (m > 0) {
        this.board[y][x] = "*";
        m--;
      }
    }
  }

  var remainingRowCount = this.r - fullColumnCount;
  //console.log(odd, fullColumnCount, remainingRowCount);
  if (((this.m > this.c && odd > 1 && fullColumnCount + 1 < this.r))
    || odd == 0 && remainingRowCount == 1
    || fullColumnCount == 0 && this.c - this.m == 1
    || (odd == remainingRowCount && fullColumnCount + 1 < this.r)) {

    if (odd == 0) {
      fullColumnCount--;
      odd = this.c;
    }

    var r;
    if (remainingRowCount - odd == 1) {
      r = this.r - 2;
    } else {
      r = this.r;
    }
    //console.log(r);

    for(var i = 0; i < odd; i++) {
      this.board[fullColumnCount][odd - 1 - i] = ".";
    }
    var y = fullColumnCount;
    var x = 0;
    //console.log(y, x, remainingRowCount);
    for(var i = 0; i < odd; i++) {
      //console.log(y, x);
      this.board[y][x] = "*";
      y++;
      if (y >= r) {
        y = fullColumnCount;
        x++;
      }
    }

  } else if(this.r > 1 && odd == 1 && remainingRowCount == 1 && (this.c + 1) % 2 == 0) {

    for(var i = 0; i < this.c; i++) {
      this.board[fullColumnCount - 1][i] = ".";
    }
    this.board[fullColumnCount][1] = ".";

    var j = (this.c + 1) / 2;

    for(var k = 0; k < 2; k++) {
      for(var l = 0; l < j; l++) {
        this.board[fullColumnCount - 1 + k][l] = "*";
      }
    }

  } else if(this.r > 1 && odd == 1 && (this.m % this.r) == 0) {

    this.initBoard();
    var m = this.m;
    for(var x = 0; x < this.c; x++) {
      for(var y = 0; y < this.r; y++) {
        if (m > 0) {
          this.board[y][x] = "*";
          m--;
        }
      }
    }

  }

}
MinesweeperMaster.prototype.setFirstClick = function() {
  this.board[this.r - 1][this.c - 1] = "c";
}
MinesweeperMaster.prototype.cloneBoard = function() {
  return JSON.parse(JSON.stringify(this.board));
}
MinesweeperMaster.prototype.init = function() {
  this.initBoard();
  this.setMines();
  this.setFirstClick();
  this.answer = this.cloneBoard();
}
MinesweeperMaster.prototype.open = function(y, x) {
  var mineCount = 0;

  if (this.board[y] == null || this.board[y][x] == null) {
    return;
  }

  if (this.board[y][x] != '.' && this.board[y][x] != 'c') {
    return;
  }

  if (this.board[y - 1] != null && this.board[y - 1][x] == '*') {
    mineCount++;
  }
  if (this.board[y + 1] != null && this.board[y + 1][x] == '*') {
    mineCount++;
  }
  if (this.board[y][x - 1] != null && this.board[y][x - 1] == '*') {
    mineCount++;
  }
  if (this.board[y][x + 1] != null && this.board[y][x + 1] == '*') {
    mineCount++;
  }
  if (this.board[y - 1] != null && this.board[y - 1][x - 1] != null && this.board[y - 1][x - 1] == '*') {
    mineCount++;
  }
  if (this.board[y - 1] != null && this.board[y - 1][x + 1] != null && this.board[y - 1][x + 1] == '*') {
    mineCount++;
  }
  if (this.board[y + 1] != null && this.board[y + 1][x - 1] != null && this.board[y + 1][x - 1] == '*') {
    mineCount++;
  }
  if (this.board[y + 1] != null && this.board[y + 1][x + 1] != null && this.board[y + 1][x + 1] == '*') {
    mineCount++;
  }

  this.board[y][x] = mineCount;

  if (mineCount != 0) {
    return;
  }

  this.open(y - 1, x);
  this.open(y + 1, x);
  this.open(y, x - 1);
  this.open(y, x + 1);
  this.open(y - 1, x - 1);
  this.open(y - 1, x + 1);
  this.open(y + 1, x - 1);
  this.open(y + 1, x + 1);
}
MinesweeperMaster.prototype.click = function() {
  for(var y = 0; y < this.r; y++) {
    for(var x = 0; x < this.c; x++) {
      if(this.board[y][x] == "c") {
        this.open(y, x);
      }
    }
  }
}
MinesweeperMaster.prototype.judge = function() {
  var res = true;
  loop1:
  for(var y = 0; y < this.r; y++) {
    for(var x = 0; x < this.c; x++) {
      if(this.board[y][x] == ".") {
        res = false;
        break loop1;
      }
    }
  }
  return res;
}
MinesweeperMaster.prototype.getAnswerAsString = function() {
  var answer = "";
  for(var y = 0; y < this.r; y++) {
    for(var x = 0; x < this.c; x++) {
      answer += this.answer[y][x];
    }
    answer += "\n";
  }
  return answer.trim();
}
MinesweeperMaster.prototype.solve = function() {
  // debug
  //console.log(this.r, this.c, this.m);

  this.init();
  var initBoard = this.cloneBoard();
  this.click();
  var clickedBoard = this.cloneBoard();
  var res = this.judge();

  // debug
  if (!res && this.r * this.c - this.m != 2) {
    //console.log(initBoard);
    //console.log(clickedBoard);
  }

  return res;
}

// main
if(process.argv.length < 3) {
  console.log("path not found.");
  process.exit(1);
}

var path = process.argv[2];
var lines = fs.readFileSync(path).toString().split('\n');

var impossibleCount = 0;

var count = lines[0];
for (var i = 0; i < count; i++) {
  var caseNo = i + 1;
  console.log("Case #" + caseNo + ":");

  var cases = lines[caseNo].trim().split(" ");
  var r = parseInt(cases[0]);
  var c = parseInt(cases[1]);
  var m = parseInt(cases[2]);
  var minesweeperMaster = new MinesweeperMaster(r, c, m);
  var ret = minesweeperMaster.solve();
  if (ret) {
    var answer = minesweeperMaster.getAnswerAsString();
    console.log(answer);
  } else {
    console.log("Impossible");
    impossibleCount++;
  }

  if(caseNo == 49) {
    //break;
  }

}

//console.log("impossibleCount: " + impossibleCount);
