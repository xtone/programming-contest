'use strict';

let fs = require("fs");

class Chick {
  constructor(cid, xi, vi) {
    this.cid = cid;
    this.xi = xi;
    this.vi = vi;
    this.goal = false;
  }
}

class PickingUpChicks {
  constructor(n, k, b, t, chicks) {
    this.n = n;
    this.k = k;
    this.b = b;
    this.t = t;
    this.chicks = chicks;
  }

  sortChicksByXi() {
    this.chicks.sort((a, b) => b.xi - a.xi);
  }

  solve() {
    if (this.k == 0) {
      return 0;
    }

    this.sortChicksByXi();

    let ret = false;
    let goalCount = 0;
    let pickCount = 0;
    for (let i = 0; i < this.chicks.length; i++) {
      let chick = this.chicks[i];
      let lastXi = chick.xi + chick.vi * this.t;
      if (lastXi >= this.b) {
        goalCount++;
        chick.goal = true;
        if (i > 0) {
          for (let j = i - 1; j >= 0; j--) {
            if (!this.chicks[j].goal) {
              pickCount++;
            }
          }
        }
      } else {
        chick.goal = false;
      }
      if (goalCount >= this.k) {
        ret = true;
        break;
      }
    }

    if (ret) {
      return pickCount;
    } else {
      return -1;
    }
  }
}

// main
if (process.argv.length < 3) {
  console.log("path not found.");
  process.exit(1);
}

let path = process.argv[2];
let lines = fs.readFileSync(path).toString().split('\n');

let count = lines[0];
let cursor = 1;
for (let i = 0; i < count; i++) {
  let caseNo = i + 1;

  let values = lines[cursor].split(' ').map(element => parseInt(element));
  cursor++;

  let n = values[0];
  let k = values[1];
  let b = values[2];
  let t = values[3];

  let xis = lines[cursor].split(' ').map(element => parseInt(element));
  cursor++;

  let vis = lines[cursor].split(' ').map(element => parseInt(element));
  cursor++;

  let chicks = [];
  for (let i = 0; i < n; i++) {
    let chick = new Chick(i + 1, xis[i], vis[i]);
    chicks.push(chick);
  }

  let pickingUpChicks = new PickingUpChicks(n, k, b, t, chicks);
  let ret = pickingUpChicks.solve();
  if (ret < 0) {
    console.log("Case #" + caseNo + ": IMPOSSIBLE");
  } else {
    console.log("Case #" + caseNo + ": " + ret);
  }
}
