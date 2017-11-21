var context = require.context('./js/test', true, /.js$/); //make sure you have your directory and regex test set correctly!
context.keys().forEach(context);
