
//   Apps Script Code

/*
function doGet(username)
{
  if (username.parameter.action == 'getUsername'){
    return getUsername();
  }
  if (username.parameter.action == 'addData'){
    return addData(username);
  }
  if (username.parameter.action == 'addQuantity'){
    return addQuantity(username);
  }
  if (username.parameter.action == 'getUserdetails'){
    return getUserdetails(username);
  }
  if  (username.parameter.action == 'deletenameData') {
    return deletenameData(username);
  }
  if  (username.parameter.action == 'deleteUserData') {
    return deleteUserData(username);
  }
}

function addData(user)
{
  var spreadsheet = SpreadsheetApp.getActiveSpreadsheet();
  var sheet = spreadsheet.getSheetByName('s11');
  var lastRow = sheet.getLastRow();
  sheet.getRange(lastRow + 1, 1, 1, 3).setValues([[user.parameter.username,user.parameter.idno,user.parameter.phoneno]]);
  return ContentService.createTextOutput("Data added successfully.");
}

function addQuantity(user)
{
  var spreadsheet = SpreadsheetApp.getActiveSpreadsheet();
  var sheet = spreadsheet.getSheetByName('s12');

  var lastRow = sheet.getLastRow();
  sheet.getRange(lastRow + 1, 1, 1, 3).setValues([[user.parameter.idno,user.parameter.qt, user.parameter.time]]);
  return ContentService.createTextOutput("Data added successfully.");
}

function getUsername()
{
  var sheet = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
  var range = sheet.getDataRange();
  var values = range.getValues();
  var headers = values[0];
  var jsonArray = [];

  for (var i = 1; i < values.length; i++) {
    var row = values[i];
    var jsonObject = {};
    for (var j = 0; j < headers.length; j++) {
      jsonObject[headers[j]] = row[j];
    }
    jsonArray.push(jsonObject);
  }

  return ContentService
      .createTextOutput(JSON.stringify(jsonArray))
      .setMimeType(ContentService.MimeType.JSON);
}

function getUserdetails(user)
{
  var spreadsheet = SpreadsheetApp.getActiveSpreadsheet();
  var sheet = spreadsheet.getSheetByName('s12');
  var range = sheet.getDataRange();
  var values = range.getValues();
  var headers = values[0];
  var jsonArray = [];

  for (var i = 1; i < values.length; i++) {
    var row = values[i];
    var jsonObject = {};


    for (var j = 0; j < headers.length; j++) {
      if(values[i][0] == user.parameter.idno){
        jsonObject[headers[j]] = row[j];
      }
    }
    if(Object.entries(jsonObject).length > 0){
      // console.log(jsonObject != jsonObject1);
      jsonArray.push(jsonObject);
    }

  }
  // console.log(jsonArray)
  return ContentService
      .createTextOutput(JSON.stringify(jsonArray))
      .setMimeType(ContentService.MimeType.JSON);
}

function deletenameData(user) {
  var spreadsheet = SpreadsheetApp.getActiveSpreadsheet();
  var sheet = spreadsheet.getSheetByName('s11'); // Adjust sheet name as needed
  var idToDelete = user.parameter.idno;
  var range = sheet.getDataRange();
  var values = range.getValues();
  var headers = values[0];
  var numRows = values.length;

  // Find the row with the matching idno
  for (var i = 1; i < numRows; i++) {
    if (values[i][1] == idToDelete) { // Assuming idno is in the second column
      sheet.deleteRow(i + 1); // Adding 1 because spreadsheet rows are 1-indexed
      return ContentService.createTextOutput("Data deleted successfully.");
    }
  }


  // If idno is not found
  return ContentService.createTextOutput("No data found with the provided idno.");



}

function deleteUserData(user) {
  var spreadsheet = SpreadsheetApp.getActiveSpreadsheet();
  var sheet = spreadsheet.getSheetByName('s12'); // Adjust sheet name as needed
  var range = sheet.getDataRange();
  var values = range.getValues();
  var numRows = values.length;

  // Extract the user parameters
  var dateAndTime = parseInt(user.parameter.dateandtime); // Assuming this is a timestamp and needs to be an integer
  // var userId = user.parameter.id;

  // Find the row with the matching idno and dateAndTime
  for (var i = 1; i < numRows; i++) {
    // Assuming id is in the first column (index 0) and dateAndTime is in the third column (index 2)
    if (parseInt(values[i][2])===dateAndTime) {
      sheet.deleteRow(i+1); // Adding 1 because spreadsheet rows are 1-indexed
      console.log(i+1);
      return ContentService.createTextOutput("Data deleted successfully.");
    }
  }

  // If idno is not found
  return ContentService.createTextOutput("No data found with the provided idno.");
}

*/