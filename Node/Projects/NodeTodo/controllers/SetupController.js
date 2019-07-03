const Todo = require('../models/TodoModel');

module.exports = function(app) {
	app.get('/api/setup-todos', function(req, res) {
		
		// seed the database
		var starterTodos = [
			{
				username: 'test',
				todo: 'buy milk',
				isDone: false,
				hasAttachment: false
			},
			{
				username: 'test',
				todo: 'feed dog',
				isDone: false,
				hasAttachment: false
			},
			{
				username: 'test',
				todo: 'learn node',
				isDone: false,
				hasAttachment: false
			}
		];

		Todo.create(starterTodos, function(err, results) {
			if (err) throw err;
			
			res.send(results);			
		});

	});
}