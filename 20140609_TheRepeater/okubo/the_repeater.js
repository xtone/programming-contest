var fs  = require("fs");

var TheRepeater = function(questions) {
  this.questions = questions;
}
TheRepeater.prototype.isFeglaWon = function(questions) {
  var shortQuestions = questions.map(function(element){
    var ret = "";
    for(var i = 0; i < element.length; i++) {
      if (ret.length < 1 || ret[ret.length - 1] != element[i]) {
        ret += element[i];
      }
    }
    return ret;
  });
  return !this.isEverySame(shortQuestions);
}
TheRepeater.prototype.isEverySame = function(questions) {
  return questions.every(function(element, index, array){
    return element == array[0];
  });
}
TheRepeater.prototype.getMaxLength = function() {
  var lengths = this.questions.map(function(element){
    return element.length;
  });
  return Math.max.apply(null, lengths);
}
TheRepeater.prototype.getReferenceCharacter = function(total) {
  var max = 0;
  var maxKey;
  for(var key in total) {
    if(total[key] > max) {
      max = total[key];
      maxKey = key;
    }
  }
  if (maxKey == 'undefined') {
    return;
  } else {
    return maxKey;
  }
}
TheRepeater.prototype.countTotal = function(index) {
  var cs = [];
  for(var j = 0; j < this.questions.length; j++) {
    var c = this.questions[j][index];
    cs.push(c);
  }

  var total = {};
  for(var k = 0; k < cs.length; k++) {
    var c = cs[k];
    if(total[c] != null) {
      total[c]++;
    } else {
      total[c] = 1;
    }
  }
  return total;
}
TheRepeater.prototype.handlingQuestions = function(index, referenceC) {
  var count = 0;
  for(var i = 0; i < this.questions.length; i++) {
    var q = this.questions[i];
    var c = q[index];
    var pc = q[index - 1];
    var nc = q[index + 1];

    if (c == referenceC || (typeof c == 'undefined' && typeof referenceC == 'undefined')) {
      continue;
    }
    if (pc == referenceC) {
      var firstHalf = q.substring(0, index);
      var secondHalf = q.substring(index, q.length);
      this.questions[i] = firstHalf + referenceC + secondHalf;
    } else if((pc != referenceC && nc == c) || pc == c){
      var firstHalf = q.substring(0, index);
      var secondHalf = q.substring(index + 1, q.length);
      this.questions[i] = firstHalf + secondHalf;
    } else {
      console.log("can't handling!");
    }
    count++;
  }
  return count;
}
TheRepeater.prototype.solve = function() {
  var count = 0;

  if (this.isFeglaWon(this.questions)){
    return -1;
  }

  if (this.isEverySame(this.questions)) {
    return count; // 0
  }

  var loop = true;
  do {

    var maxLength = this.getMaxLength();
    for(var i = 0; i < maxLength; i++) {
      //console.log(i, this.questions);
      var total = this.countTotal(i);
      if(Object.keys(total).length == 1) {
        continue;
      }
      var referenceC = this.getReferenceCharacter(total);
      var tempCount = this.handlingQuestions(i, referenceC);
      if (tempCount > 0) {
        count += tempCount;
        break;
      }
    }

    if (this.isEverySame(this.questions)) {
      loop = false;
    }

  } while (loop);

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

  var questionCount = parseInt(lines[cursor]);
  cursor++;

  var questions = [];
  for(var j = 0; j < questionCount; j++) {
    var index = cursor + j;
    questions.push(lines[index]);
  }
  var theRepeater = new TheRepeater(questions);
  var ret = theRepeater.solve();

  if (ret < 0) {
    console.log("Case #" + caseNo + ": Fegla Won");
  } else {
    console.log("Case #" + caseNo + ": " + ret);
  }

  cursor = cursor + questionCount;

  if (caseNo == 2) {
//    break;
  }
}

