#!/usr/bin/osascript -l JavaScript

function run(argv){
  var img = argv[0];
  var app = Application("iTerm");
  app.currentTerminal.currentSession.backgroundImagePath = img || null;
}
