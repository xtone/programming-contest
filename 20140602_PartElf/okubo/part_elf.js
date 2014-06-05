var fs  = require("fs");
var bigRat = require("big-rational");

var PartElf = function(vida, maxGenerationNo) {
  this.vida = bigRat(vida);
  this.maxGenerationNo = maxGenerationNo;
}
PartElf.prototype.solve = function() {
  var rat = this.vida;
  var generationNo = 0;
  var tempGenerationNo = 0;
  var loop = true;
  do {
    generationNo++;
    rat = rat.multiply(2);

    if (rat.equals(1)) {
      loop = false;
    } else if (rat.greater(1)) {
      if (tempGenerationNo == 0) {
        tempGenerationNo = generationNo;
      }
      rat = rat.subtract(1);
    }

    if (generationNo >= this.maxGenerationNo) {
      loop = false;
      tempGenerationNo = 0;
      generationNo = -1;
    }

  } while(loop);

  if (tempGenerationNo > 0) {
    return tempGenerationNo;
  } else {
    return generationNo;
  }
}

// main
if(process.argv.length < 3) {
  console.log("path not found.");
  process.exit(1);
}

var MAX_GENERATION_NO = 40;

var path = process.argv[2];
var lines = fs.readFileSync(path).toString().split('\n');

var count = lines[0];
for (var i = 0; i < count; i++) {
  var caseNo = i + 1;
  var line = lines[caseNo];
  var partElf = new PartElf(line.trim(), MAX_GENERATION_NO);
  var generationNo = partElf.solve();
  if (generationNo > 0) {
    console.log("Case #" + caseNo +": " + generationNo);
  } else {
    console.log("Case #" + caseNo +": impossible");
  }
}
