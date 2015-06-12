"use strict";

var fs = require("fs");

class YourRankIsPure {
  constructor(n) {
    this.n = n;
  }

  combinations(array, count) {
    if (array === undefined) {
      array = [];
    }
    if (count === undefined) {
      count = 0;
    }
    var keys = [];
    var arrayLength = array.length;
    var index = 0;
    for (var i = 0; i < count; i++) {
      keys.push(-1);
    }
    var digitKey = array.indexOf(count + 1);
    var ret = 0;
    while (index >= 0) {
      if (keys[index] < arrayLength - (count - index)) {
        for (var key = keys[index] - index + 1; index < count; index++) {
          keys[index] = key + index;
        }
        var digitIndex = keys.indexOf(digitKey);
        if (digitIndex < 0) {
          continue;
        }
        var item = keys.map( (c) => array[c] );
        if (this.isPure(item)) {
          //console.log(item + " ok");
          ret++;
        } else {
          //console.log(item + " ng");
        }
      } else {
        index--;
      }
    }
    return ret;
  }

  isPure(subset) {
    var index = subset.length + 1;
    var isPure = false;
    var loop = true;
    do {
      if (index === 1) {
        isPure = true;
        loop = false;
      } else {
        var _index = subset.lastIndexOf(index);
        if (_index > -1) {
          subset = subset.slice(0, _index);
          index = _index + 1;
        } else {
          isPure = false;
          loop = false;
        }
      }
    } while (loop);
    return isPure;
  }

  countSubsets() {
    var candidates = [];
    for (var i = 2; i < this.n; i++) {
      candidates.push(i);
    }
    var count = 0;
    for (var j = 0; j < candidates.length + 1; j++) {
      var digit = j + 1;
      if (digit < 3 || digit === this.n - 1) {
        count++;
      } else {
        count += this.combinations(candidates, digit - 1);
      }
    }
    return count;
  }

  solve() {
    var ret = this.countSubsets();

    return ret % 100003;
  }
}

// main
if (process.argv.length < 3) {
  console.log("path not found.");
  process.exit(1);
}

var path = process.argv[2];
var lines = fs.readFileSync(path).toString().split("\n");

var count = lines[0];
var cursor = 1;
for (var i = 0; i < count; i++) {
  var caseNo = i + 1;

  var n = parseInt(lines[cursor]);
  cursor++;

  var yourRankIsPure = new YourRankIsPure(n);
  var ret = yourRankIsPure.solve();
  console.log("Case #" + caseNo + ": " + ret);
}
