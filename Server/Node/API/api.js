// Implements a quick store to mongodb for Backbone.js

var MongoClient = require('mongodb').MongoClient
  , assert = require('assert');

// Connection URL
var url = 'mongodb://localhost:27017/genericDataStore';

// Use connect method to connect to the Server
MongoClient.connect(url, function(err, db) {
	assert.equal(null, err);
	console.log("Connected correctly to server");

	db.close();
});

var express = require('express'), 
	app = express.createServer(), 
	_ = require('underscore');

app.configure(function () {
	app.use(express.bodyParser());
	app.use(allowCrossDomain);
});

app.get("/:collection", function(req, res) {
	console.log('read ' + req.params.collection);

	MongoClient.connect(url, function(err, db) {
	  	assert.equal(null, err);

		findDocuments(req, db, function(docs) {
			console.dir(docs);
			db.close();
			res.send(docs == null ? 404 : docs);
		});
	});
});

// create -> POST /collection
app.post('/:collection', function(req, res){
	console.log('create ' + req.params.collection);

	MongoClient.connect(url, function(err, db) {
		assert.equal(null, err);

		insertDocuments(req, db, function(result) {
			db.close();
			res.send(req.body);
		});
	});
});

// read -> GET /collection[/id]
app.get('/:collection/:id?', function (req,res) {
	console.log('read ' + (req.params.id || ('collection ' + req.params.collection)));

	if (!req.params.id) {
		res.send(404);
		return;
	}

	MongoClient.connect(url, function(err, db) {
	  	assert.equal(null, err);

		findDocument(req, db, function(model) {
			db.close();
			res.send(model);
		});
	});

});

// update -> PUT /collection/id
app.put('/:collection/:id', function (req,res) {
  	console.log('update ' + req.params.collection + ' - ' + req.params.id);

	MongoClient.connect(url, function(err, db) {
	  	assert.equal(null, err);

		updateDocument(req, db, function() {
			db.close();
			res.send(req.body);
		});
	});

});

// delete -> DELETE /collection/id
app.delete('/:collection/:id', function (req,res) {
  	console.log('delete ' + req.params.collection + ' - ' + req.params.id);

	MongoClient.connect(url, function(err, db) {
		assert.equal(null, err);

	  removeDocument(req, db, function(model) {
	    db.close();
	    res.send(model);
	  });
	});

});

app.listen(3002);

function allowCrossDomain(req, res, next) {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE');
    res.header('Access-Control-Allow-Headers', 'Content-Type');

    next();
}

//MONGO INSERT
var insertDocuments = function(req, db, callback) {
	// Get the documents collection
	console.log("Mongo insert");
	var collection = db.collection(req.params.collection);
	// Insert some documents
	collection.insert(req.body, function(err, result) {
		assert.equal(null, err);
	callback(result);
	});
}

//MONGO FIND
var findDocuments = function(req, db, callback) {
	console.log("Mongo find");
	var collection = db.collection(req.params.collection);
	// Find some documents
	collection.find({}).toArray(function(err, docs) {
		assert.equal(null, err);
	callback(docs);
	});     
	}

	//MONGO FINDONE
	var findDocument = function(req, db, callback) {
	console.log("Mongo find");
	var collection = db.collection(req.params.collection);

	// Find one document
	collection.findOne(req.body, function(err, res) {
		assert.equal(null, err);
		callback(res == null ? {} : res);
	});
}

//MONGO REMOVE
var removeDocument = function(req, db, callback) {
	console.log("Mongo remove");
	// Get the documents collection
	var doc = {'_id' : req.params.id};
	console.log(doc);

	var collection = db.collection(req.params.collection);

	collection.find(doc, function(err, model) {
		collection.findOne(doc, function(err, res) {
			assert.equal(null, err);
			collection.remove(doc, function(err, result) {
				callback(res == null ? {} : res);
			});
		});
	});   
}

//MONGO UPDATE
var updateDocument = function(req, db, callback) {
	console.log("Mongo update");
	// Get the documents collection
	var doc = {'_id' : req.params.id};
	console.log(doc);

	var collection = db.collection(req.params.collection);
	collection.remove(doc, function(err, result) {
		collection.insert(req.body, function(err, result) {
			callback(result);
		});
	});
}