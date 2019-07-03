Trey Hakanson

09/13/2018

---

# Sprint 4

## LevelManager and Updates

The `LevelManager` class was initially tasked with loading the level from the deserialized XML files. The level manager now also handles reseting, creating checkpoints, and warping:

```cs
// Reset the game
public void Reset(GameTime gameTime);

// Update the memento
public void Checkpoint();

// Warp Mario
public void WarpTo(Motion motionObj);
```

Thus, the level manager is doing a lot of heavy lifting at this point. In particular, warping Mario seems like an odd duty for the level manager to be handling. While the checkpoint and reset logically makes sense for the manager to handle, it would be nice if they were separated out into a separate object to keep things tidy.

In addition to the level manager adding an `Update` method, a few other classes also feature update methods:

```cs
// Game.cs
public void Update(GameTime gameTime)
{
  ...

  // Update miscellaneous
  _gameTimer.Update(gameTime);
  _audioPlayer.Update();
  _levelManager.Update();
  _hud.Update();

  ...
}
```

It would be nice to have a an interface, perhaps called `IUpdatable`, that classes could implement if they had an update method. This way, the above code could be changed to the following, which is more maintainable moving forward:

```cs
// IUpdatable.cs
interface IUpdatable
{
  // NOTE: requires all `Update` methods to take a `GameTime` argument
  void Update(GameTime gameTime);
}

// Game.cs
List<IUpdatable> _updatables = new List<IUpdatable>();

...

public void Update(GameTime gameTime)
{
  ...

  foreach (var updatable in _updatables)
  {
    updatable.Update(GameTime gameTime);
  }

  ...
}
```

## Time Overview

Time to complete: **45 minutes**
