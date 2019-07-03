Lesson 2

---

# Problem Solving

## Difficulties in Problem Solving

Intelligent agents have difficulty solving problems with a large amount of states

In addition, partial observablity also leads to difficult divisions

## Definition of a Problem

- Initial State
- Actions(s) -> { a1, a2, a3 } (may or may not depend on the initial state, s)
- Result(s, a) -> s (based on the state and the action taken, yields a result, aka a new state)
- Goal_Test(s) -> Bool (was the resulting state a goal?)
- Path_Cost(state_action_paths) -> cost (the "cost" of each state-action transaction involved in getting to this state)
    - Done in terms of step cost, which is modeled by Step_Cost(s1, a, s2) -> cost

## Searching Routes

In searching for a route between point A and point B, assume that a step is the movement from the current location (state), to a new location (next state). Thus, movement can only occur between cities connected to the current location.

In the example of searching for a route, the cost of a step would be something like distance (although in a more complex scenario, things like fuel, terrain, etc. may be factored in)

Their are 3 components to a problem like this with regards to the regions; the **explored** is places the agent has been, the **unexplored** is places the agent has not, and the **frontier** is the current location (state) of the agent

Psuedocode for a "Tree Search" example search algorithm through routes:

```
function Tree_Search(problem):
    frontier = {[ Initial_State ]}
    loop:
        if frontier is empty: return FAIL
        path = remove_choice(frontier) // this is where variation can occur
        s = path.end
        if Goal_Test(s): return path
        for a in actions:
            add [path + a -> Result(s, a)] to frontier
```

- `remove_choice` is where variety is introduced; for the `Tree_Search` and `Graph_Search` examples we will assume it is "breadth first"
 - Remove all paths that branch from the current state first

Main problem with tree search is that it is not aware of duplicate paths; for example, when moving from A -> B, moving back to state A will always be an options at state B, thus creating wasted resources by getting stuck in a recursive loop.

Psuedocode for a "Graph Search" algorithm, which corrects the problem stated above:

```
function Graph_Search(problem):
    frontier = {[ Initial_State ]}
    explored = {}
    loop:
        if frontier is empty: return FAIL
        path = remove_choice(frontier) // this is where variation can occur
        s = path.end
        add s to explored
        if Goal_Test(s): return path
        for a in actions:
            add [path + a -> Result(s, a)] to frontier
            unless result(s, a) in frontier + explored
```

**Keep in mind that for Tree_Search and Graph_Search the goal is not reached until the path is added to explored, not the frontier**

- "uniform cost search" is also an option for `remove_choice`
    - as each path is expanded, the cumulative cost of arriving to each point on the frontier is computed, and the shortest path is always taken
- "depth first" is another options
    - essentially the opposite of "breadth first", but this algorithm is **NOT** optimal because it will not always find the shortest path
        - Still useful due to storage considerations; the frontier at any given moment for a depth first search is considerably shorter than breadth first when dealing with large trees
    - Another issue with depth first traversal is that it is not guaranteed to hit a goal state; if there is an infinite path, it will continue down that path indefinitely. Breadth first is always gaurenteed to find the goal, as is cost first (assuming paths are of finite cost)
- Uniform cost has issues because it not really directed at the goal; one can expect to search through about half the area before reaching the goal, which for a large environment is usually unacceptable. There is not really any way to remedy this without adding additional information
    - one way to give additional information is to give a sense of direction to the goal, which allows for biasing towards it, significantly improving speed. This is know as a "greedy best first" search
        - This has its flaws too, as it does not take into account potential impedments when approaching the goal via the shortest path
- A* search works by always expanding the path who has the lowest value for the function `f = g + h`, where:
    - `g(path) = path cost`
    - `h(path) = h(s) = estimated distance to the goal`
    - this is the best possible strategy in the sense that it finds the shortest length path, while also expanding the least number of paths required
    - A* will only find the lowest cost path if:
        - h(s) < true cost
            - h can't overestimate the distance to the goal

## Conclusions

Since A* is the optimal value, all the intelligence of a given agent is contained in its heuristic function h(s). The key to AI will be to develop agents that can come up with there own heuristic functions

If h1 and h2 are admissable, then a new heuristic h could be described as `h = max(h1, h2)`

problems with search stem from the agents following a given set of rules, and not being able to "improvise" as it goes and acquires new information

Problem solving via search works when:

- the domain is fully observable (can see our initial state and actions)
- the set of available actions must be known
- the domain must be discrete
- the domain must be deterministic, we have to know the result of taking an action
- the domain must be static; no actions outside of our own can affect the state
