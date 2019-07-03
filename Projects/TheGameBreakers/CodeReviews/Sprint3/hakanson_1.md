Trey Hakanson

08/27/2018

---

# Sprint 3

## BaseEntity (and TheGameBreakers.Entity in general)

In this sprint a motion object was added to each `BaseEntity` to allow for preservation of action state as needed. However, this attribute does not offer top-level getters/setters, so accessors must do this:

```cs
entity.MotionObj.PositionX
```

Instead of:

```cs
/*
Is a getter (and maybe also a setter):
public PositionX => MotionObj.PositionX
 */
entity.PositionX
```

This is feature envy, and requires all accessors to know of the underlying implementation of the motion object. This is easy to fix however, and will be refactored in the next sprint.

In addition, the entity chain is starting to get relatively complicated with the introduction of additional subclasses and interfaces; namely the `ISpawnerEntity` and `ItemBlockEntity`. The depth of inheritance for a block entity that can spawn items is as follows:

```cs
ItemBlockEntity -> BlockEntity, ISpawnerEntity -> CollidableEntity -> BaseEntity
```

There doesn't appear to be a great way to avoid this without repeating code, which would be a code smell. Perhaps providing some documentation would be useful to the team though, as not everyone has worked within the entities equal amounts, so making changes requires a slight learning curve.

The implementation of `CollidableEntity` was also edited in this sprint to be more memory efficient in terms of action callbacks. Before, all collision objects were present on each entity, and were overridden as needed (the default behavior was to do nothing). The new implementation allows subclasses to add callbacks to a collision map, allowing them to only carry the data that they actually need, which not only makes the code cleaner, but also more efficient.

## Time Overview

Time to complete: **45 minutes**
