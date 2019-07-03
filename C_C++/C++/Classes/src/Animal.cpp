#include <iostream>

#include "Animal.h"

using namespace std;


Animal::Animal(string name) {
	// in C++, `this` is the pointer of the current object
	this->happiness = true;
	this->name = name;
	cout << "Animal born!" << endl;
}

// this is the preferred way of setting default values, where possible; this is
// marginally faster (called an Initialization List). Can mix and match this
// format for different values within one constructor
Animal::Animal(string name, bool happiness): name(name), happiness(happiness) {
}

Animal::~Animal() {
	cout << "Animal died..." << endl;
}

void Animal::setHappiness(bool happiness) {
	this->happiness = happiness;
}

void Animal::speak() {
	if (this->happiness) {
		cout << "Hello world! I'm " << this->name << endl;
	} else {
		cout << "I'm angry." << endl;
	}
}

void Animal::action() {
	cout << "Performing an action." << endl;
}
