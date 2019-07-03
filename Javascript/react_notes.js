// github project links:
	// https://github.com/StephenGrider/ReduxCasts

// creating a new react app
// npm install -g create-react-app
// create-react-app app-name
// cd app-name
// npm start

// JSX allows for html type syntax in javascript files.
// element represents a react object
const element = <h1>Hello World!</h1>;
const element = (
	<div className="aClass">
		<h1>Hello World!</h1>
		<h2>Nesting is just fine</h2>
	</div>
); 
// notice that attributes in JSX are camelcase since they are closer to Javascript than HTML/XML 
// (class is reserved, so className is used)

// Babel compiles JSX down to React.createElement()
// example: these two are identical
const element = (
  <h1 className="greeting">Hello, world!</h1>
);

const element = React.createElement(
  'h1',
  { className: 'greeting' },
  'Hello, world!'
);

// React.createElement() essentially creates the following object
// Note: this structure is simplified
const element = {
  type: 'h1',
  props: {
    className: 'greeting',
    children: 'Hello, world'
  }
};

var imageUrl = "https://domain.com/image.png";
const profileImg = <img src={ imageUrl } /> // can use {} curly braces to embed a js variable/attribute

// react elements are immutable, so in order to update them must render() again
// this is fine though, because react only updates what's necessary. So in the following example,
// only the content is changed (not a new element or anything)
function tick() {
  const element = (
    <div>
      <h1>Hello, world!</h1>
      <h2>It is {new Date().toLocaleTimeString()}.</h2>
    </div>
  );
  ReactDOM.render(
    element,
    document.getElementById('root')
  );
}

setInterval(tick, 1000);

// Components and Props
// Components let you split the UI into reusable, isolated pieces. Props are arbitrary inputs taken in by a component
// Can use function or class notation (class has a few additional features, functions are more concise)
function Welcome(props) {
	return <h1>Welcome { props.name }!</h1>;
}

class Welcome extends React.Component {
	render() {
		return <h1>Welcome { this.props.name }!</h1>;
	}
}

// can now use these user-defined components with JSX
// note that user-defined components start with capital letters, DOM elements (div, h1, p, etc.) start with lowercase letters
const welcome = <Welcome name="Trey" />; // name is passed to either the function or class in the "props" variable

// components can contain other components, but must have a single base element (regardless of whether or not they
// contain custom components)
function Greetings(props) {
	return (
		<div>
			<Welcome name="Trey" />
			<Welcome name="Ian" />
			<Welcome name="Dan" />
			<Welcome name="Greg" />		
		</div>
	);
}

// props are not mutable

// States and lifecycle
// for this example we'll fix the clock example from earlier
function tick() {
  const element = (
    <div>
      <h1>Hello, world!</h1>
      <h2>It is {new Date().toLocaleTimeString()}.</h2>
    </div>
  );
  ReactDOM.render(
    element,
    document.getElementById('root')
  );
}

setInterval(tick, 1000);

// self contained example
class Clock extends React.Component {
	constructor(props) {
		super(props); // always need to call the super with props arg when overriding the constructor
		this.state = { date: new Date() }; // state is similar to props, but is private and fully 
		// controlled by the component
	}

	// componentDidMount and componentWillUnmount are "lifecycle hooks"
	componentDidMount() { // component DOM was added (rendered for the first time)
		this.timerID = setInterval(
			() => this.tick(),
			1000
		); // if you don't use the variable in render(), it shouldn't be attached
		// to state. That's why timerID is just attached to the component itself (this)
	}

	componentWillUnmount() { // component DOM will be removed
		clearInterval(this.timerID);
	}

	tick() {
		this.setState({
			date: new Date()
		});
	}

	render() {
		return (
			<div>
				<h1>Hello, World</h1>
				<h2>It is { this.state.date.toLocaleTimeString() }.</h2>
			</div>
		);		
	}
}

ReactDOM.render(
	<Clock />,
	document.getElementById('root')
);

// 3 things to keep in mind about setState():
//		1. Do not modify state directly
			// wrong, this won't re-render the component
			this.state.val = "new value";
			// correct, will re-render
			this.setState({
				val: "new value"
			});
//		2. you should not rely on this.props or this.state when updating
//		   a state value because both of these variables are updated asynchronously
//		   (for preformance reasons) and may not be correct
				// wrong
				this.setState({
					counter: this.state.counter + this.props.increment
				});
				// correct
				this.setState((prevState, props) => ({
					counter: prevState.counter + props.increment
				}));
				// or (without arrow function)
				this.setState(function(prevState, props) {
					return {
						counter: prevState.counter + props.increment;
					};
				});
//		3. State updates are merged
			this.state = {
				val1: "Hello",
				val2: "World",
				val3: "!"
			}

			this.setState({
				val3: "?" // only overrides val3, leaves val1 and val2 intact
			})

// Data flows down
// state is not accessible to any other components, so child and parent elements 
// cannot tell whether others are stateful or stateless
// may chose to pass state down to children via props ("top-down" or "unidirectional")
// example: could pass date to h1 in clock if desired
<h1>It is { this.state.date.toLocaleTimeString() }.</h1>

// event handling is JSX is similar to standard DOM methods
var handlingFunc = () => console.log("hit");
<button onclick={ handlingFunc }>
	Handle some Stuff
</button>

// must explicitly call "preventDefault" in react, can't stop default behavior by returning false

// inlining if logic in JSX
function Mailbox(props) {
	const unread = props.unread;
	return (
		<h1>Hello!</h1>
		{ unread.length > 0 && // expression always evaluates to true, so as long as unread.length > 0 is true the expression will return
			<h2>You have { unread.length } unread message{ unread.length > 1 ? '' : 's' }</h2>
		}
	);
}

// if a component function returns "null" it will not render the component

// can reder multiple componenets from an array
const nums = [1, 2, 3, 4, 5];
const lis = nums.map(num =>
	<li>{ num }</li>
);
ReactDOM.render(
	<ul>{ lis }</ul>,
	document.getElementById('root')
);
// the following is a better solution to this chunk:
function NumberList(props) { // its best to render anything more than a very simple component as a custom component
	const nums = props.nums;
	const lis = nums.map(num =>
		<li key={num.toString()}>
			{num}
		</li>
	); // to avoid throwing a warning, need a "key" on li elements basically, keys are needed
	// for components in an array to help them be identified in case of re-rendering
	// best to use unique ids rather than indexes in case the list can be reordered, but indexing
	// is ok sometimes (if nothing else is available and the list won't change order)
	// keys only need to be unique among siblings, not globally
	// keys don't get passed to components, only serve as a hint to react. If you need the key passed
	// to the component, pass another prop with the same value
	return <ul>{lis}</ul>

}
const nums = [1, 2, 3, 4, 5];
ReactDOM.render(
	<NumberList nums={nums} />
	document.getElementById('root');
)

// Forms: Controlled and Uncontrolled components
// a controlled component provides a "value" prop and does not maintain its own internal
// state; the component renders based purely on props
render() {
	return (<input
		type="text"
		value="Hello World!" />
	);
} // doesn't change as you type, simply renders "Hello World!" every time

// need to use the "onchange" event in order to actually maintain state
class Form extends React.Component {
	constructor(props) {
		super(props);
		this.state = {value: ''};
		this.handleChange = this.handleChange.bind(this);
		this.handleSubmit = this.handleSubmit.bind(this);
	}

	handleChange(event) { // very easy and clean to validate input here
		this.setState({value: event.target.value});
	}

	// could also very easily create another function to clear the input
	// following an arbitrary action

	handleSubmit(event) {
		alert("The value of the field is: " + this.state.value);
	}

	render() {
		return (
			<div>
				<input type="text"
					placeholder="Hello!"
					value={this.state.value}
					onchange={this.handleChange} />
				<button onclick={this.handleSubmit}>
					Submit
				</button>
			</div>
		);
	}
}

ReactDOM.render(
	<Form />,
	document.getElementById('root')
);

// IMPORTANT FROM THE REACT DOCS
// ### Potential Issues With Checkboxes and Radio Buttons ###
// Be aware that, in an attempt to normalize change handling for checkboxes and radio inputs, 
// React listens to a click browser event to implement the onChange event. For the most part 
// this behaves as expected, except when calling preventDefault in a change handler. preventDefault 
// stops the browser from visually updating the input, even if checked gets toggled. This can be 
// worked around either by removing the call to preventDefault, or putting the toggle of checked 
// in a setTimeout.

// uncontrolled inputs don't take a value and will accept any user input, but
// seem pretty useless

// the "defaultValue" prop sets a default value for an input, checkbox, radiobutton, etc.

// user interactions supported by forms
	// value: supported by <input>, <textarea>
	// checked: supported by <input> components of type "checkbox" or "radio"
	// selected: supported by <option> components

	// onchange fires when any of these events are triggered

// REACT 'FAKER' WILL GENERATE PLACEHOLDER TEXT

// #########################
// ##      ANIMATION      ##
// #########################
// module for animations in react
tN

...
	renderStuff() {
		// render some somponents in here, and all the animations for
		// ReactCSSTransitionGroup will be applied to them upon 
		// entering/exiting the view
	}

	render() {
		const transitionOptions = {
			transitionName: 'fade',
			transitionEnterTimeout: 500,
			transitionLeaveTimeout: 500
		}

		return (
			<div>
				<ReactCSSTransitionGroup {...transitionOptions} >
					{this.renderStuff()}
				</ReactCSSTransitionGroup>
			</div>
		);

	}
...

// then must define and initial and final state for the transitionName in
// css (need to include transition property in active states, also need to
// follow the format <transition-name>-enter, <transition-name>-leave-active,
//  etc.)

/* starting state of the entering animation */
.fade-enter {
	/* some css */
}

/* end state of the entering animation */
.fade-enter-active {
	/* some css */
}

/* starting state of the leaving animation */
.fade-leave {
	/* some css */
}

/* end state of the leaving animation */
.fade-leave-active {
	/* some css */
}

// ######################
// ##      MODALS      ##
// ######################
// in order to modals being displayed under content, it's important
// to not create a modal as a child of an element other than the 
// document's body. This way it will not be hampered by the 
// z-indexes of it's parent/sibling elements. 

// Should instead create a "fake modal" at any level that calls for
// the creation of the true modal on the document's body
// Example of the Modal class:
import React, { Component } from 'react';
import ReactDOM from 'react-dom';

class Modal extends Component {
	componentDidMount() {
		// create a div to represent our modal, save it on the component
		// for later access
		this.modalTarget = document.createElement('div');

		// apply a class of modal to the new element
		this.modalTarget.className = 'modal';

		// add the newly created modal to the document's body
		document.body.appendChild(this.modalTarget);

		// call the _render method
		this._render();
	}

	_render() {
		// render a div containing the children passed in with
		// the component's props into the modalTarget that was
		// created in the componentDidMount method (which has
		// already been bound to the document's body)
		ReactDOM.render(
			<div>{this.props.children}</div>,
			this.modalTarget
		);

		// must be careful including redux connected children in
		// the modal; elements exporting using the redux "connect"
		// function need access to the outermost "Provider" tag in
		// order to function properly. Will throw an "invariant"
		// error if a redux container placed out of context like 
		// this. Thus, the modal actually needs to have its own
		// "Provider" tag if redux containers are to be used within
		// the modal, like so:
		
		// would need these imports at the top of the file too:
		// import { store } from '../index'; (assuming ../index contains the store, as it should)
		// import { Provider } from 'react-redux';

		ReactDOM.render(
			<Provider store={store}>
				<div>{this.props.children}</div>
			</Provider>,
			this.modalTarget
		); // redux container children are now good to go
	}

	render() {
		// noscript renders nothing on the page
		return <noscript />;
	}

}

export default Modal;

// ######################################
// ##  OBJECT VS ARRAY BASED REDUCERS  ##
// ######################################
// when working with a list of of posts/objects
// with ids that may need to be mutated and or
// updated, it's often easier to work with an
// object of the from { id: post } as it is much
// easier to find and update specific posts this
// way

// with an array
const updatedPost = { /* some object */ };
filteredPosts = posts.filter(post => post.id !== updatedPost.id);
return filteredPosts.concat(updatedPost);

// no filtering, finding, etc. when working with objs:
return { ...posts, [updatedPost.id]: updatedPost };

// lodash function 'mapKeys' works awesome for object based
// reducers; it can map an array of objects into an object
// with a specific property from the objects used as the key
// example:
const arr = [
	{id: 1, name: 'a'},
	{id: 2, name: 'b'},
	{id: 3, name: 'c'},
]
const obj = _.mapKeys(arr, 'id');
// obj looks like this:
obj = {
	1: {id: 1, name: 'a'},
	2: {id: 2, name: 'b'},
	3: {id: 3, name: 'c'},
}

// ########################################
// ##  	   		DEPLOYMENT 				  ##
// ########################################
// Development Pipeline
// Code -> Webpack -> Webpack Dev Server -> localhost:8080

// Production Pipeline
// Code -> Push to Heroku -> Install NPM Modules -> Run 'postinstall' -> Run 'start' -> xyz.herokuapp.com 
// npm run postinstall -> Runs immediately after installing npm packages
	// this is where we want to tell webpack to "build" the application and produce
	// bundle.js
// npm run start -> responsible for starting and maintaining the server
// need to add both the postinstall and start scripts to package.json
"scripts": {
	"postinstall": "webpack -p", // this simple command will tell webpack to create a bundle.js
	"start": "node server.js" // this server file will build/maintain the server
}

// example server.js (for Heroku)
const express = require('express');
const path = require('path');
const port = process.env.PORT || 8080; // this line is specific to Heroku, which provides a PORT environment variable
const app = express();

app.user(express.static(__dirname));
app.get('*', (req, res) => {
	res.sendFile(path.resolve(__dirname, 'index.html'));
}); // if the server can't resolve what file the user is trying
// to get, just send index.html

app.listen(port);
console.log('Server Started');

// run "heroku logs" if anything goes wrong (console.logs in server.js/postinstall.js will appear here too)














	


