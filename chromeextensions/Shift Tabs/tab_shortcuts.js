chrome.commands.onCommand.addListener(function(command) {
   chrome.tabs.update({}, function(tab) {
      console.log(tab.index);
      if (command == 'move-tab-one-left')
         chrome.tabs.move(tab.id, {index: tab.index-1});
      else if (command == 'move-tab-one-right')
         chrome.tabs.move(tab.id, {index: tab.index+1});
      else if (command == 'move-tab-far-left')
         chrome.tabs.query({pinned:true, currentWindow:true},
            function(t) {
               chrome.tabs.move(tab.id, {index: t.length})});
      else if (command == 'move-tab-far-right')
         chrome.tabs.move(tab.id, {index: -1});
   });
});
