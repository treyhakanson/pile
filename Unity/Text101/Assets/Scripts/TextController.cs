using System.Collections;
using UnityEngine;
using UnityEngine.UI; // brings in unity UI elements

public class TextController : MonoBehaviour {
	// this makes a text variable of type Text availble to the entire program.
	// This will later be connected to the Text UI element created in Unity
	public Text text;
	private enum StoryState { cell, mirror, lock_0, sheets_0, cell_mirror, sheets_1, lock_1, freedom };
	private StoryState storyState;

	// Use this for initialization
	void Start () {
		storyState = StoryState.cell;
	}
	
	// Update is called once per frame
	void Update () {
		switch (storyState) {
			case StoryState.cell: 			
				state_cell();
				break;
			case StoryState.mirror:
				state_cell();
				break;
			case StoryState.sheets_0:
				state_sheets_0();
				break;
			case StoryState.lock_0:
				state_cell();
				break;
			case StoryState.cell_mirror:
				state_cell();
				break;
			case StoryState.sheets_1:
				state_cell();
				break;
			case StoryState.lock_1:
				state_cell();
				break;
			case StoryState.freedom:
				state_cell();
				break;
		}
	}

	void state_sheets_0() {
		text.text = "State - Sheets 0 (Press R to Return to Cell)";

		if (Input.GetKeyDown(KeyCode.R))
			storyState = StoryState.cell;
	}

	void state_cell() {
		text.text = "State - Cell (Press S to Look at Sheets)";
		
		if (Input.GetKeyDown(KeyCode.S))
			storyState = StoryState.sheets_0;
	}
}