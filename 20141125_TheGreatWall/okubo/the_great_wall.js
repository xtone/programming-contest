var fs  = require("fs");

var Tribe = function(di, ni, wi, ei, si, delta_di, delta_pi, delta_si) {
  this.di = parseInt(di);
  this.ni = parseInt(ni);
  this.wi = parseInt(wi);
  this.ei = parseInt(ei);
  this.si = parseInt(si);
  this.delta_di = parseInt(delta_di);
  this.delta_pi = parseInt(delta_pi);
  this.delta_si = parseInt(delta_si);
}
var Attack = function(di, wi, ei, si) {
  this.di = di;
  this.wi = wi;
  this.ei = ei;
  this.si = si;
}
var TheGreatWall = function(tribes) {
  this.tribes = tribes;
}
TheGreatWall.prototype.createTimeline = function() {
  var timeline = [];
  for(var i = 0; i < this.tribes.length; i++) {
    var tribe = this.tribes[i];
    var di;
    var si;
    var wi;
    var ei;
    for(var j = 0; j < tribe.ni; j++) {
      di = tribe.di + tribe.delta_di * j;
      si = tribe.si + tribe.delta_si * j;
      wi = tribe.wi + tribe.delta_pi * j;
      if(wi < 0) {
        wi = 0;
      }
      ei = tribe.ei + tribe.delta_pi * j;
      if (ei < 0) {
        ei = 0;
      }
      var attack = new Attack(di, wi, ei, si);
      timeline.push(attack);
    }
  }
  timeline.sort(function(a, b){
    return a.di - b.di;
  });
  return timeline;
}
TheGreatWall.prototype.solve = function() {
  var count = 0;
  var timeline = this.createTimeline();
  console.log(timeline);
  return count;
}

// main
if(process.argv.length < 3) {
  console.log("path not found.");
  process.exit(1);
}

var path = process.argv[2];
var lines = fs.readFileSync(path).toString().split('\n');

var count = lines[0];
var cursor = 1;
for (var i = 0; i < count; i++) {
  var caseNo = i + 1;

  var tribesCount = parseInt(lines[cursor]);
  cursor++;

  var tribes = [];
  for(var j = 0; j < tribesCount; j++) {
    var index = cursor + j;
    var _t = lines[index].split(" ");
    var tribe = new Tribe(_t[0], _t[1], _t[2], _t[3], _t[4], _t[5], _t[6], _t[7]);
    tribes.push(tribe);
  }
  var theGreatWall = new TheGreatWall(tribes);
  var ret = theGreatWall.solve();
  console.log("Case #" + caseNo + ": " + ret);
  cursor = cursor + tribesCount;
}

