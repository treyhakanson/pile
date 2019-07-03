# Trey Hakanson

11/29/2018

---

# Sprint 5

## Health Bar

To implement Mario's health bar, both the `MarioEntity` and `Hud` were updated. Within `MarioEntity`, and enumeration was used to keep track of health waypoints. This is a good pattern, as it prevents duplicating magic numbers, which is not only prone to error but becomes difficult to update down the line. Throttling was also added upon Mario getting hit, which is also a nice design to prevent Mario from rapidly taking multiple hits, which would have made the health bar essentially useless otherwise. The `TakeDamage` function now directly calls to set the state on the `MarioStateMachine`. This makes the method a bit hairy, and mixes calls to `SetState`, which should really only be done within the state machine by calling actions. It would have been a more sustainable design to change the state machine to take in the Mario entity on calls to `TakeDamage`, and then allow that action within the state machine to incur the correct change. In this case, the health enumeration could have also been moved to the state machine, along with maybe the rest of the health variables, which could just be given a public accessor for the HUD to prevent feature envy.

As for the HUD, it simply accesses the health, and draws the bar accordingly. Nothing particularly interesting going on here. However, it does seem unnecessary to store Mario's health on `Update`, when the `Draw` method could just access the same property as needed without the intermittent storage.

## Time Overview

Time to complete: **30 minutes**
