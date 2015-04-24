var fs  = require("fs");

var FileFixIt = function(existsPaths, targetPaths) {
  this.existsPaths = existsPaths;
  this.targetPaths = targetPaths;
}
FileFixIt.prototype.isExistsPath = function(path) {
  //console.log("isExistsPath path: " + path + " existsPaths: " + this.existsPaths);
  return this.existsPaths.indexOf(path) > -1;
}
FileFixIt.prototype.getDepth = function(path) {
  var pathElemets = path.split("/");
  pathElemets.shift();
  return pathElemets.length;
}
FileFixIt.prototype.solve = function() {
  var count = 0;

  if (this.targetPaths.length == 0) {
    return count;
  }

  for(var i = 0; i < this.targetPaths.length; i++) {
      var targetPath = this.targetPaths[i];
      //console.log("targetPath: " + targetPath);

      var depth = this.getDepth(targetPath);
      var _targetPath = targetPath;
      for(var j = 0; j < depth; j++) {
        if (this.isExistsPath(_targetPath)) {
          //console.log("exists");
          break;
        }
        //console.log("make");
        count++;
        this.existsPaths.push(_targetPath);
        _targetPath = _targetPath.slice(0, _targetPath.lastIndexOf("/"))
      }
  }

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
  //console.log("Case #" + caseNo);
  var nums = lines[cursor].split(' ').map(function(element){return parseInt(element)});
  cursor++;

  var existsPathsNum = nums[0];
  var targetPathsNum = nums[1];

  var existsPaths = [];
  for(var j = 0; j < existsPathsNum; j++) {
    existsPaths.push(lines[cursor]);
    cursor++;
  }

  var targetPaths = [];
  for(var k = 0; k < targetPathsNum; k++) {
    targetPaths.push(lines[cursor]);
    cursor++;
  }

  //console.log(existsPaths);
  //console.log(targetPaths);

  var fileFixIt = new FileFixIt(existsPaths, targetPaths);
  var ret = fileFixIt.solve();
  console.log("Case #" + caseNo + ": " + ret);
}
