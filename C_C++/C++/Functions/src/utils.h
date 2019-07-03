/*
 * utils.h
 *
 *  Created on: Sep 14, 2017
 *      Author: treyhakanson
 */

// this line says if UTILS_H_ is not defined, define it. This prevents the contents
// of the file from being included multiple times in one project; if one file has already
// included UTILS_H_, another file with the include will not attempt to also insert the
// contents of utils.h, but they will be available. Once again, this is a statement for
// the preprocessor not a C++ statement.
#ifndef UTILS_H_
#define UTILS_H_


// what's actually written in place of the include, if not already defined
void doSomething();


#endif /* UTILS_H_ */
