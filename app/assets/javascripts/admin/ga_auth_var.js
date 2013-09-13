// Copyright 2012 Google Inc. All Rights Reserved.

/* Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/**
 * @fileoverview Utility for handling authorization and updating the UI
 * accordingy.
 * @author api.nickm@gmail.com (Nick Mihailovski)
 */

/**
 * Callback executed once the Google APIs Javascript client library has loaded.
 * The function name is specified in the onload query parameter of URL to load
 * this library. After 1 millisecond, checkAuth is called.
 */
var apiKey = 'AIzaSyDPpGs5UHCAzi7zaB4b65bI0KB_nTE1E5w';
var clientId = '1064062597356.apps.googleusercontent.com';
var scopes = 'https://www.googleapis.com/auth/analytics.readonly';

function handleClientLoad() {
  gapi.client.setApiKey(apiKey);
  // window.setTimeout(checkAuth, 1);
}

$(document).ready(function() {
     handleClientLoad();
     checkAuth();
});


/**
 * Uses the OAuth2.0 clientId to query the Google Accounts service
 * to see if the user has authorized. Once complete, handleAuthResults is
 * called.
 */
function checkAuth() {
  gapi.auth.authorize({
    client_id: clientId, scope: scopes, immediate: true}, handleAuthResult);
}


/**
 * Handler that is called once the script has checked to see if the user has
 * authorized access to their Google Analytics data. If the user has authorized
 * access, the analytics api library is loaded and the handleAuthorized
 * function is executed. If the user has not authorized access to their data,
 * the handleUnauthorized function is executed.
 * @param {Object} authResult The result object returned form the authorization
 *     service that determine whether the user has currently authorized access
 *     to their data. If it exists, the user has authorized access.
 */
function handleAuthResult(authResult) {
  if (authResult) {
    gapi.client.load('analytics', 'v3', handleAuthorized);
  } else {
    handleUnauthorized();
  }
}


/**
 * Updates the UI once the user has authorized this script to access their
 * data. This changes the visibiilty on some buttons and adds the
 * makeApiCall click handler to the run-demo-button.
 */
function handleAuthorized() {
  var authorizeButton = document.getElementById('authorize-button');

  authorizeButton.style.visibility = 'hidden';
  makeApiCall();
}


/**
 * Updates the UI if a user has not yet authorized this script to access
 * their Google Analytics data. This function changes the visibility of
 * some elements on the screen. It also adds the handleAuthClick
 * click handler to the authorize-button.
 */
function handleUnauthorized() {
  var authorizeButton = $("#authorize-button");
  var runDemoButton = $('#run-demo-button');

  runDemoButton.style.visibility = 'hidden';
  authorizeButton.style.visibility = '';
  authorizeButton.onclick = handleAuthClick;
  outputToPage('Please authorize this script to access Google Analytics.');
}


/**
 * Handler for clicks on the authorization button. This uses the OAuth2.0
 * clientId to query the Google Accounts service to see if the user has
 * authorized. Once complete, handleAuthResults is called.
 * @param {Object} event The onclick event.
 */
function handleAuthClick(event) {
  gapi.auth.authorize({
    client_id: clientId, scope: scopes, immediate: false}, handleAuthResult);
  return false;
}
