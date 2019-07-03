Trey Hakanson

08/27/2018

---

# Sprint 1

## TheGameBreakers

## TheGameBreakers.Command

**Author:** Trey Hakanson

The command package contains a few top level files, `ICommand.cs` and `QuitCommand.cs`. `ICommand.cs` provides a simple interface to implement a generic command, and `QuitCommand.cs` is currently the only "game-level" command.

Not a whole lot to take about here; only consideration moving forward is that as more game-level commands are added (show menu, exit menu, etc.), it likely makes sense to group them into a separate package.

### TheGameBreakers.Command.Block

**Author:** Trey Hakanson

The block commands are all implementations of the abstract class `BlockCommand`, which is itself an implementation of the `ICommand` interface. The block command handles implementing a constructor for concrete command subclasses, to save rewriting to the `Entity` member variable. This prevents the code smell of repeat code, which is important to prevent rot.

The commands are all very simple, as they should be, all featuring simple line `Execute` methods.

### TheGameBreakers.Command.Mario

**Author:** Trey Hakanson

Only the abstract class for Mario commands is present at this level. Similar to the above `BlockCommand`, this class provides a constructor to concrete subclasses, eliminating repeat code.

#### TheGameBreakers.Command.Mario.Action

**Author:** Trey Hakanson

The same structure as the commands in the block package: simple concrete subclasses of an abstract class, which implements the `ICommand` interface.

#### TheGameBreakers.Command.Mario.PowerUp

**Author:** Trey Hakanson

The same structure as the commands in the block package: simple concrete subclasses of an abstract class, which implements the `ICommand` interface.

## TheGameBreakers.Controller

**Authors:** Trey Hakanson, Dan Arters

The controllers follow a similar pattern to the commands. There is a generic interface, and an abstract class to minimize code repetition. However, the abstract `Controller` class is much meatier here. The abstract class features a centralized throttler/debouncer to limit input and handle returning to default (idle) state. The abstract controller is also a generic class, that requires a parameter to specify the key type of the command mappings. This was done to maximize the flexibility of the controller, as any hashable type (keyboard keys, gamepad buttons, etc.) can be used for mappings. The controller also handles the constructor and adding commands and invoking them, so that the concrete controllers can focus solely on processing how their specific input devices require being checked for updates.

The benefits of this approach are visible in the concrete implementations `GamePadController` and `KeyboardController`, as both feature only simple `Update` method overrides.

## TheGameBreakers.Entity

**Author:** Trey Hakanson, Jacob Lingo

The entities compose stat machines and sprite factories to provide the full functionality required for a given in game entity. The `MarioEntity` initializes Mario's action and power-up state machines, as well as his sprite factory. It them creates a mapping of full state to sprite, via a nested dictionary. The dictionary also serves to cache each sprite, so that each instance of an entity does not waste computation creating new sprites on state update (the same pattern is seen in `BlockEntity`). The main difference between the block entity are the utility methods to instantiate different blocks (set the initial state). These methods prevent the need for separate state machines for each type of block, as well as separate entities. This also gives us the flexibility to given block entities types on the fly, in response to various stimuli. Lastly, the block entity also features an idea of "Settling". Although the timing is currently hardcoded, a method of dynamically determining timing based on block sprite frames is described in the entity constructor.

This dictionary sprite mapping pattern is very interesting in my opinion, because it allows for full state mapping without any switch cases or if statements. It may seem a little odd at first, but I feel the benefits are worth the initial shock of the large dictionary.

## TheGameBreakers.Factory

**Authors:** Dan Arters, Jacob Lingo

Each factory was quite simple; all only return sprites with the correct locations and dimensions according to the sprite sheet. I'd like to give Dan a shout out for finding the correct locations for each sprite as well as hand-editing them where needed, as this was a very time consuming part of the project that may be lost in the code.

## TheGameBreakers.Sprites

**Authors:** Dan Arters

The sprites feature a simple interface, and have been condensed down into only 2 concrete classes. The `NullSprite` follows the null design pattern and ensures no unexpected race conditions on `Draw` or `Update`. The `Sprite` concrete class can handle frame-cycling for animations as well as static sprites.

### TheGameBreakers.State.Block

**Author:** Trey Hakanson

Every concrete state subclass is derived from the `BlockState` abstract. This abstract provides empty bodies for each possible action, so that if a particular state does not have a transition for a given action, it does not need to implement an empty method. The concrete states are all quick simple, simply changing the state as needed. The block state machine provides a top-level interface for invoking each action, and calls said action on the current state. The state machine also implements the concept of "settling", locking the state during a fixed transition. This can be seen in the `SetState` method; _feedback on this would be much appreciated, as we were unsure of possible better approaches._

### TheGameBreakers.State.Mario

**Author:** Trey Hakanson

The Mario state machines are essentially exactly the same as the block state machines, minus the concept of settling. There are two state machines because Mario's current action state is independent of his current power-up state, and thus separating them out minimized the number of states.

_please note that there are some unused states that are included as placeholders for future work._

## Time Overview

Time to complete: **1 hour**

This code review did not take particularly long to complete due to small team size; I had interacted with essentially every part of the project and thus did not need much time to assess it.

## Suggestions

Overall, the project is in good shape, with high maintainability, readability, and cohesion. However, one change that would ease a lot of headaches is to standardize our in-game object naming conventions. The state machines and sprite factories in particular clash on this front; for example, the state machines use the word "idle" whereas the factories tend to say "stationary". Luckily, this is more of a logistical change and will not be a difficult refactor. In order to keep the project more organized in this regard moving forward, the team will need to improve communication and possibly detail naming conventions within VSTS tasks.
