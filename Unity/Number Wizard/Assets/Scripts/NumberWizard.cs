using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class NumberWizard: MonoBehaviour {
	// C# is statically typed
	int max = 1000; // these values are globally scoped to the entire instance
	int min = 1;

	public Text title;
	public Text subtitle;
	public Text response;

	// Use this for initialization
	void Start () {
		// like swift, C# requires string literals to be in
		// double quotes. Single quotes are reserved for
		// character literals
		print("Welcome to Number Wizard!");
		print("Pick a number in your head, but don\'t tell me!");

		// interpolated strings are preceded by a $, and
		// use curly braces for the variable names
		print($"the largest number you can pick is {max}");
		print($"and the lowest number you can pick is {min}");

		// this just handles the edge case of 1000; without
		// this, the max integer that will be guessed is 999
		// (due to rounding)
		this.max++;

		this.AskQuestion();
	}

	// Update is called once per frame
	void Update() {
		if (Input.GetKeyDown(KeyCode.UpArrow)) {
			this.min = this.ComputeGuess();
			this.AskQuestion();
		} else if (Input.GetKeyDown(KeyCode.DownArrow)) {
			this.max = this.ComputeGuess();
			this.AskQuestion();
		} else if (Input.GetKeyDown(KeyCode.Return)) {
			print("I won!");
		}
	}

	int ComputeGuess() {
		return (this.min + this.max)/2;
	}

	void AskQuestion() {
		print($"Is the number higher or lower than {this.ComputeGuess()}");
		print("[Up] Higher, [Down] Lower, [Enter] equal"); 
	}
}
