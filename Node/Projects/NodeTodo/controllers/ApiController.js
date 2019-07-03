const Todo = require('../models/TodoModel');
const bodyParser = require('body-parser');

module.exports = function(app) {

	app.use(bodyParser.json());
	app.use(bodyParser.urlencoded({ extended: true }));

	app.get('/api/todos/:username', function(req, res) {
		Todo.find({ username: req.params.username }, function(err, todos) {
			if (err) throw err;
			res.send(todos);
		});
	});

	app.get('/api/todo/:id', function(req, res) {
		Todo.findById(req.params.id, function(err, todo) {
			if (err) throw err;
			res.send(todo);
		});
	});

	app.post('/api/todo', function(req, res) {
		// if an id is sent, then udpate the exsiting todo with that id
		if (req.body.id)
			Todo.findByIdAndUpdate(req.body.id, {
				todo: req.body.todo,
				isDone: req.body.isDone,
				hasAttachment: req.body.hasAttachment
			}, function(err) {
				if (err) throw err;
				res.send('Successfully Updated');
			});
		// otherwise, create a new todo
		else {
			const newTodo = Todo({
				username: 'test',
				todo: req.body.todo,
				isDone: req.body.isDone,
				hasAttachment: req.body.hasAttachment
			});

			newTodo.save(function(err) {
				if (err) throw err;
				res.send('Successfully Created');
			});
		}
		
	});

	app.delete('/api/todo', function(req, res) {
		Todo.findByIdAndRemove(req.body.id, function(err) {
			if (err) throw err;
			res.send('Successfully Deleted');
		});
	});

}
