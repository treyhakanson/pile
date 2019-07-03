var g = G$("Trey", "Hakanson", "en");
g.greet(); // passed nothing, so will give an informal greeting and return 'this' since the
// method is chainable

// could use chaining linke this:
g.greet().setLang('es').greet(true); // will give informal, change lang to spanish, and then give formal