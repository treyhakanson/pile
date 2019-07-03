// ##########################
// ##       REDUCERS       ##
// ##########################
	// "conatiners" are componenets that have access to the redux state
	// through reducers and action creators

	// reducers: a function that returns a piece of the application state
	// need the "connect" import and the "mapStateToProps" function:
	import { connect } from 'react-redux';
	function mapStateToProps(state) {
		return {
			// this object will be available in the props of the
			// implementing container
		};
	}
	// must bind reducers so the application knows to send actions to them
	import { combineReducers } from 'redux';
	import Reducer1 from './reducer_example_1';
	import Reducer2 from './reducer_example_2';

	const rootReducer = combineReducers({
	  red1: Reducer1,
	  red2: Reducer2
	});

	export default rootReducer; // Reducer1 and Reducer2 are now registered reducers and
	// will receive actions

// ##########################
// ##   ACTION CREATORS    ##
// ##########################
	// action creators: a function that creates an action to be handled
	// by reducers
	// need the "bindActionCreators" import and the "mapDispatchToProps"
	// function
	import { bindActionCreators } from 'redux';
	function mapDispatchToProps(dispatch) {
		// any key added to the object, such as action, when called
		// will hit all the reducers in the application
		return bindActionCreators({action: functionName}, dispatch);
	}
	// actions don't need to be bound or specified in any particular
	// way, just imported into the containers binding them

// ########################
// ##    REDUX THUNK     ##
// ########################
// [Github Link](https://github.com/gaearon/redux-thunk)
// a library for asynchronous action creators
// an alternative/complement to redux promise, that allows
// for async actions to be handled by action creators by
// allowing them to return functions rather than just values

// action flow in a redux application
//													 --> Reducer
// 												/
// Action Creator -> Action -> Dispatch --> Reducer
// 												\
//													 --> Reducer

// normal redux action creators must return plain js objects,
// but redux thunk gives us the option of returning a plain js
// function:
...
const FETCH_DATA = 'FETCH_DATA';
...
export function fetchData() {
	const promise = axios.get('http://example.com/');

	return (dispatch) => {
		promise.then(
			({ data }) => {
				dispatch({
					type: FETCH_DATA,
					payload: data
				});
			}
		);
	};
}

// #########################
// ##      RESELECT       ##
// #########################
// [Github Link](https://github.com/reactjs/reselect)
// allows for the creation of "Selectors" that allow for
// values to be derived from multiple reducers without
// having to create a component with explicit knowledge
// of the structures involved in each reducer

// Typically create a separate "selectors" directory to
// house any reselect selectors

// Example Senario:
// Have a posts reducer (all post objects) and a selected 
// posts reducer (ids of selected posts), and want to 
// display the selected posts in a an area separate to all
// the posts
	
	// Normal Redux Solution: 
	// would have to have a componenet
	// that using the selected posts reducer and posts reducer
	// to filter through the posts it needs

	// reselect Solution:
	// have a reselect selector get the product you're looking
	// for and distribute it to the componenet
	// example code of selector, assuming a posts and selectedPostIdss
	// reducer exists:
		// ## SELECTOR ##
		import { createSelector } from 'reselect';

		// this selector will intercept the pieces of the state we
		// care about
		const postsSelector = state => state.posts;
		const selectedPostSelector = state => state.selectedPostIds;

		const getPosts = (posts, selectedPostIds) => {
			// if the post id is in selectedPostIds, store it in selectedPosts array
			const selectedPosts = posts.filter(post =>
				selectedPosts.indexOf(post.id) !== -1);
			
			return selectedPosts;
		};

		export default createSelector(
			postsSelector, // all inputs other than the last are state selection functions, intercepting pieces of the state
			selectedPostSelector, // all inputs other than the last are state selection functions, intercepting pieces of the state
			getPosts // the last input is a function that will take the result of all the preceding state selection functions
			// and output the final result
		);

		// ## COMPONENT ##
		import React from 'react';
		import { connect } from 'react-redux';
		import SelectedPostsSelector from 'path/to/selector';

		const SelectedPostList = ({ posts }) => {
			return (
				<ul>
					{
						posts.map(post => 
							<li key={post.key}>{post.title}</li>)
					}
				</ul>
			);
		};

		const mapStateToProps = state => {
			return {
				posts: SelectedPostsSelector(state) // making use of the selector
			};
		};

		export default connect(mapStateToProps)(SelectedPostList);

// To create more reusable componenets, instead of fetching data in componentWillMount,
// you can fetch data in onEnter using react-router
// Example:
// route_callbacks.js (same level as routes.js, likely in a routes folder)
import store from 'path/to/store';
import { action } from 'path/to/action';

export function onEnterSomething() {
	store.dispath(action());
}

<Route path="path" component={ComponentName} onEnter={onEnterSomething} />

// #########################
// ##     REDUX FORM      ##
// #########################

















