var fs  = require("fs");

var CookieClicker = function(c, f, x) {
  this.c = c; // クッキーファームを買うのに必要なクッキー数
  this.f = f; // クッキーファームによって追加されるクッキー数
  this.x = x; // 目標クッキー数
}
CookieClicker.prototype.trial = function(cookieFarmBuyPlan) {
  var loop = true;
  var scale = 10000000;
  var seconds = 0;
  var cookieCount = 0;
  var cookieCountPerSecond = 2 / scale;
  var f = this.f / scale;
  do {
    seconds++;
    cookieCount = cookieCount + cookieCountPerSecond;
    //console.log("seconds: " + seconds + " cookieFarmBuyPlan: " + cookieFarmBuyPlan + " cookieCount:" + cookieCount + " cookieCountPerSecond:" + cookieCountPerSecond);
    if (cookieFarmBuyPlan == 0 && cookieCount >= this.x) {
      loop = false;
    } else if (cookieFarmBuyPlan > 0 && cookieCount >= this.c) {
      cookieCount = cookieCount - this.c;
      cookieCountPerSecond = cookieCountPerSecond + f;
      cookieFarmBuyPlan--;
    }
  } while (loop);
  return seconds / scale;
}
CookieClicker.prototype.solve = function() {
  var loop = true;
  var minSeconds = Number.MAX_VALUE;
  var cookieFarmBuyPlan = 0;
  do {
    var seconds = this.trial(cookieFarmBuyPlan);
    //console.log(seconds, minSeconds);
    if (seconds >= minSeconds) {
      loop = false;
    } else {
      minSeconds = seconds;
      cookieFarmBuyPlan++;
    }
  } while (loop);
  return minSeconds;
}

// main
if(process.argv.length < 3) {
  console.log("path not found.");
  process.exit(1);
}

var path = process.argv[2];
var lines = fs.readFileSync(path).toString().split('\n');

var count = lines[0];

for (var i = 0; i < count; i++) {
  var caseNo = i + 1;
  var line = lines[caseNo];
  var cfx = line.split(' ');
  var c = parseFloat(cfx[0]);
  var f = parseFloat(cfx[1]);
  var x = parseFloat(cfx[2]);
  console.log(c, f, x);
  var cc = new CookieClicker(c, f, x);
  var seconds = cc.solve();
  console.log("Case #" + caseNo +": " + seconds.toFixed(7));
  console.log("---");
}
