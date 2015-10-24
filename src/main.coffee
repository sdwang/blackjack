window.stack = window.prompt "How many chips would you like to start with?"
new AppView(model: new App()).$el.appendTo 'body'