Trey Hakanson

10/16/2018

---

# Sprint 2

## TheGameBreakers.Collider

**Author:** Dan Arters

- The collision detector needs to take the grid into account when determining which entities should be compared for collisions. Will become important onces collisions with entities other than mario also need to be checked.

## TheGameBreakers.Entity

**Authors:** Trey Hakanson, Dan Arters

- The addition of the collidable entity abstract allows for easy addition of behavior for the various types of collisions, while providing default behavior
- The same mapping pattern as seen in the state machine is used to determine the collision type, making it easily extensible
- Handling of velocity changes was delegated to the state machine actions, as depending on the transition, velocity changes vary

## TheGameBreakers.Level

**Author:** Jacob Lingo

- The level loader should be more static; there is no need to instantiate anything, and there are no instance variables.
- A variable of constants (eg. 16, 14) should be kept in a more central location, and made available to the rest of the application

## TheGameBreakers.State

**Author:** Trey Hakanson

- As mentioned earlier, the statemachine is now coupled to the base entity, as it needs to be aware of velocity so the appropriate transitions can be incurred. This feels a bit odd, but seemed like the only way to properly affect velocities. Other statemachines/entities will need to be updated similarly, for example once enemy states become more complex.

## Time Overview

Time to complete: **1 hour**

This code review did not take particularly long to complete due to small team size; I had interacted with essentially every part of the project and thus did not need much time to assess it.

## Suggestions

Overall, things are progressing smoothly. Coordination across entities, state machines, and the colliders could start to get a bit complicated given the current infrastructure once physics are added. However, thinking through these changes will only help us to strength the core and improve our design moving forward.
