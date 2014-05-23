var fs  = require("fs");

var lines = fs.readFileSync('../input/A-small-practice.in').toString().split('\n');

var count = lines[0];

for (var i = 0 ; i < count; i++) {
  var firstIndex = i * 10 + 1;
  var firstNum = parseInt(lines[firstIndex]);
  var firstRows = lines[firstIndex + firstNum].split(' ');
  var secondIndex = i * 10 + 6;
  var secondNum = parseInt(lines[secondIndex]);
  var secondRows = lines[secondIndex + secondNum].split(' ');

  var filteredRows = firstRows.filter(function(element, index, array){
    return (secondRows.indexOf(element) > -1);
  });

  var log = "Case #" + (i + 1) + ": ";
  switch (filteredRows.length) {
    case 0:
      log += "Volunteer cheated!";
      break;
    case 1:
      log += filteredRows[0];
      break;
    default:
      log += "Bad magician!";
      break;
  }

  console.log(log);
}
