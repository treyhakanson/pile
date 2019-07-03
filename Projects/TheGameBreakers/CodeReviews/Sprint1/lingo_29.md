Author: Jacob Lingo
Date: 9/27/18
Sprint: 1
Code Review

Files: /Command/*
Authors: Trey Hakanson
	* Creates a simple interface to execute commands
	* Simple to add more commands, grouped in folders to make easily readable and easier to find specific commands
	* BlockCommand and MarioCommand function are almost identical. They possess their respective block and mario entities so that when all block / action / powerup command
	  implmentations do not need to create a new entity. 

Files /Controller/*
Authors: Trey Hakanson, Dan Arters
	* Allows for a reusable keyboard / gamepad controller that could be inserted into any set of code and work without any changes.
	* Requires all keys and commands to be added in the Game1.cs file. This will most likely need to be moved into a unqiue file in the future
	* Contains a MarioEntity in command.cs that is un-needed
	* Needed very little modifications to get working from sprint 0
	
Files: /Entity/MarioEntity
Author: Trey Hakanson
	* MarioEntity takes the ActionStateMachine, PowerupStateMachine, and MarioSpriteFactory to create a complex dictionary to return the desired sprites based on a given state
	* The dictionary seems complex, however it really simplifies the process of getting the correct sprite. Each action state functions as a key with a corresponding value that contains the correct sprite
	  for whichever powerup state mario is in
	* We could possibly simplify the dictionary by making it more like the BlockEntity dictionary. Have 3 dictionarys for each powerup state with the key corresponding to the correct action state
	* Next we would need a simple if statement to select between the powerup states. It may be simpler to understand but I doubt it will affect performance

	
Files /State/*
Author: Trey Hakanson
	* This is easily the most difficult portion of the project and Trey did a very good job in creating the mario and block statemachines and respective state files
	* The framework for most future commands is present, so they can be easily implemented in future sprints
	* In order for the state machines to work, the entities must be aware of and understand how the statemachine works, or else they won't be able to correctly call state changes
	* This may need to be addressed in the future through a seperate interface or other class
	* The blockstatemachine is fairly simple in comparison to the mariostatemachine since the blocks do much less than mario. 
	* This state machine addresses a transition time so that the states cannot be manipulated over and over, which allows for the blocks to correctly transition states (ex bump)
	* Bump will most likely be able to address any item that needs to come out of a block, but it may be easier to have more states so its not defined by block. 
	
Overall:
	* I think we are in a fairly good spot, despite only having 3 members. We have all communicated well and been able to meet reguarly to accomplish the requried goals. 
	* The code is easy to understand and is simple enough to modify and build upon
	* Most elements are fairly module, so we have been able to write portions seperately then easily connect them together at the end without issue.
	