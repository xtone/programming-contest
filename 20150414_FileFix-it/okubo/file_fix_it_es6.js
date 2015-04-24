'use strict';

let fs  = require("fs");

class FileFixIt {
  constructor(existsPaths, targetPaths) {
    this.existsPaths = existsPaths;
    this.targetPaths = targetPaths;
  }

  getDepth(path) {
    let pathElemets = path.split("/");
    pathElemets.shift();
    return pathElemets.length;
  }

  solve() {
    let count = 0;

    if (this.targetPaths.length == 0) {
      return count;
    }

    for (let targetPath of this.targetPaths) {
        let depth = this.getDepth(targetPath);
        let _targetPath = targetPath;
        for(let j = 0; j < depth; j++) {
          if (this.existsPaths.has(_targetPath)) {
            break;
          }
          count++;
          this.existsPaths.add(_targetPath);
          _targetPath = _targetPath.slice(0, _targetPath.lastIndexOf("/"))
        }
    }

    return count;
  }
}

// main
if(process.argv.length < 3) {
  console.log("path not found.");
  process.exit(1);
}

let path = process.argv[2];
let lines = fs.readFileSync(path).toString().split('\n');

let count = lines[0];
let cursor = 1;
for (let i = 0; i < count; i++) {
  let caseNo = i + 1;
  //console.log("Case #" + caseNo);
  let nums = lines[cursor].split(' ').map( element => parseInt(element) );
  cursor++;

  let existsPathsNum = nums[0];
  let targetPathsNum = nums[1];

  let existsPaths = new Set();
  for(let j = 0; j < existsPathsNum; j++) {
    existsPaths.add(lines[cursor]);
    cursor++;
  }

  let targetPaths = new Set();
  for(let k = 0; k < targetPathsNum; k++) {
    targetPaths.add(lines[cursor]);
    cursor++;
  }

  let fileFixIt = new FileFixIt(existsPaths, targetPaths);
  let ret = fileFixIt.solve();
  console.log("Case #" + caseNo + ": " + ret);
}
