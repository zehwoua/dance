function getVisitorChartData(result) {
  var entries = result.feed.getEntries();
  var returningVisitors = [];
  var newVisitors = [];
  var days = [];
  var maxReturningVisitors = 0;
  var maxNewVisitors = 0;

  for (var i = 0, entry; entry = entries[i]; ++i) {
    var visType = entry.getValueOf('ga:visitorType');
    var numVisits = entry.getValueOf('ga:visits');
    var day = parseInt(entry.getValueOf('ga:day'), 10);

    // At the beginning of each day, check if data was missing for previous
    // day.  Insert "0" in appropriate visitor's array as necessary, using
    // fillToSameSize helper method.
    if (!days.length) {
      days.push(day);
    } else {
      var lastDay = days[days.length - 1];
      if (day != lastDay) {
        days.push(day);
        fillToSameSize(newVisitors, returningVisitors);
      }
    }

    if (visType == 'New Visitor') {
      newVisitors.push(numVisits);
      maxNewVisitors = Math.max(maxNewVisitors, numVisits);
    } else {
      returningVisitors.push(numVisits);
      maxReturningVisitors = Math.max(maxReturningVisitors, numVisits);
    }
  }
  fillToSameSize(newVisitors, returningVisitors);

  return {
    'returningVisitors': returningVisitors,
    'newVisitors': newVisitors,
    'maxNewVisitors': maxNewVisitors,
    'maxReturningVisitors': maxReturningVisitors,
    'days': days
  };
}

function fillToSameSize(firstArray, secondArray) {
  if (firstArray.length < secondArray.length) {
    firstArray.push(fillValue);
  } else if (secondArray.length < firstArray.length) {
    secondArray.push(fillValue);
  }
}