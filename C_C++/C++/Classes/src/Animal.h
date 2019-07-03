/*
 * Animal.h
 *
 *  Created on: Sep 14, 2017
 *      Author: treyhakanson
 */

#include <iostream>

using namespace std;

#ifndef ANIMAL_H_
#define ANIMAL_H_


// could define all methods here, but its best practice to define in a separate file
// (in-line implementations)
class Animal {
public:
	Animal(string name);
	Animal(string name, bool hapiness);
	~Animal(); // deconstructor
	void setHappiness(bool happiness);
	void speak();
	void action();

private:
	bool happiness; // can set defaults here in C++ 11 (normally do in constructor)
	string name;
};


#endif /* ANIMAL_H_ */
