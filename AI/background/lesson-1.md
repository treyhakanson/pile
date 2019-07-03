Lesson 1

---

# Intelligent Agents

## Overview

- An **intelligent agent** is the name of an AI program

- An intelligent agent is exposed to an environment, which is can learn the state of through **sensors** and manipulate through **actuators**

- The big question of AI is what the function that maps the sensors' inputs to the actuators' output looks like, which is called the intelligent agent's **control policy**

    - aka, how does the agent make decisions based on input?

    - the cycle of sensor, to actuation, to environment and back is called the **perception action cycle**

## Terminology

- If an agent's environment is fully observable if at any point in time, enough information is available to make the optimal decision

    - Otherwise, the environment is said to be partially observable, and memory is required to save information about the environment so a conclusion can be draw once enough data is had

- An agents environment is said to be deterministic if the agent's actions uniquely determine their own outcome

    - An example would be chess, because where pieces are moved and the impact each move has on the game is pre-determine

- An agents environment is said to be stochastic if there is an element of randomness

    - Driving is an example, because no matter how the agent acts other drivers are unpredictable

- Actions are discrete if there are a finite number of possibilities, and continuous if otherwise

- Benign environments have no objective that opposes the agent (ex: weather). And adversarial environment is the opposite (ex: games)
    - This makes adversarial environments more difficult to make good decisions in, since the opponent is actively attempting to counteract the agent's actions

## AI as Uncertainty Management

Answers the question of "What should you do when you don't know what to do?"

Sources of uncertainty

- sensor limits

- adversaries

- stochastic environments

- laziness

- ignorance
