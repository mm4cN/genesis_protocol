<div align="center">

# 🌌 **GENESIS PROTOCOL**
### *A game about creating a world that learns what it is.*

![Banner](docs/banner.png)

</div>

---

## 🎨 World Palette

| Element | Color | HEX Code |
|:---------|:--------|:----------|
| Void Background | 🖤 Deep Black | `#0C0C0F` |
| Form | 🟦 Structural Blue | `#5BA4FF` |
| Time | 🟣 Pulsating Violet | `#A874FF` |
| Entropy | 🔴 Deep Crimson | `#D13B3B` |
| Symmetry | 🟢 Reflective Green | `#4BD86B` |
| Memory | 🟡 Golden Trace | `#FFDE6A` |
| Rhythm | 🟠 Amber Beat | `#F9A04E` |
| Identity | ⚪ Neutral Gray | `#D1D1D1` |
| Change | 🌈 Iridescent Gradient | *(animated)* |

> Colors represent the world’s Principles — use them consistently across UI and shaders.

---

<div align="center">

![World Map](docs/world_hex_preview.png)

</div>

---

## 🪞 Introduction

> “There is nothing — yet.  
> No rules, no shape, no purpose.  
> But there is you.”  

**Genesis Protocol** is a tactical-philosophical creation game  
where players do not compete but **co-create the laws of reality**.  

Each player is an **aspect of consciousness**, seeking to give meaning to the void.  
Together, you form a world that **evolves on its own**  
and then **reveals who you were**, based on your decisions.

There are no winners.  
Only different paths toward understanding.

---

## 🧩 Phases of Existence

### 🔮 I. Creation — *Thought Becomes Form*

- Play **Idea Cards** to create or modify world hexes.  
- Each hex carries a **Principle** — a localized law of being.  
- The world maintains four core metrics:  

  | Symbol | Parameter | Meaning |
  |:--:|:--|:--|
  | 🜁 | `Order` | stability and structure |
  | 🜃 | `Entropy` | transformation and decay |
  | 🜂 | `Coherence` | harmony and interconnection |
  | 🜄 | `Growth` | expansion of existence |

> Every decision leaves a mark on the world.  
> The world remembers you before you understand yourself.

---

### 🌱 II. Manifestation — *The World Demands Form*

Once Principles are shaped, **Manifestations** arise — entities, processes, phenomena.  
Each behaves differently depending on surrounding Principles.

📘 *Example:*  
> The **Echo** card repeats the last event in a *Time* field,  
> disintegrates within *Entropy*,  
> and solidifies within *Form*.

> Every session becomes a new ecosystem of logic.  
> Every world — a different philosophy.

---

### ⚙️ III. Flow — *The World Begins to Breathe*

Principles interact.  
Manifestations respond.  
The world evolves autonomously.  

> Do not control. Observe.  
> Your thoughts are already in motion.

---

### 🕰️ IV. Revelation — *Consciousness Reaches Its Limit*

The process concludes when the world reaches one of its final states:

| 🌌 State | Description | Symbolic Meaning |
|:--|:--|:--|
| 🜁 **Harmony** | High order and coherence | The world understood itself. |
| 🜃 **Collapse** | High entropy | The world could not sustain itself. |
| 🜄 **Expansion** | Rapid growth | Existence exceeded comprehension. |
| ⚫ **Dissolution** | Loss of structure, void | The world forgot it was alive. |

At this stage, the system reveals your **Archetype of Consciousness** —  
not by choice, but through the resonance of your decisions.

---

## 🜂 Archetypes of Consciousness

| Icon | Archetype | Drive | Symbolic Meaning |
|:--:|:--|:--|:--|
| 🔥 | **Catalyst** | Accelerates change, raises Entropy | Motion, flame, impulse |
| 🪨 | **Stabilizer** | Maintains structure and laws | Solidity, gravity, stone |
| 🎵 | **Symphonist** | Unites Principles in harmony | Rhythm, resonance |
| 🕳️ | **Nihilist** | Dissolves meaning, extinguishes being | Silence, void |
| 🌿 | **Expander** | Creates new tiles and domains | Growth, space |
| 🌈 | **Shapeshifter** | Never adheres to one idea | Freedom, chaos |

> “The world sees you — even when you cannot see yourself.”

---

<div align="center">

![Archetypes Wheel](docs/archetypes_wheel.png)

</div>

---

## 🧠 Lexicon

| Former Term | New Meaning |
|:--------------|:--------------|
| *Player* | **Aspect of Consciousness** |
| *Opponent* | **Different Resonance** |
| *Turn* | **Cycle** |
| *Attack / Defense* | **Influence / Stabilization** |
| *Victory* | **Fulfillment of Intention** |
| *Points* | **World Resonance** |
| *End of Game* | **Revelation** |

---

## 💫 Tutorial (Prologue)

1. **The Void**  
   Empty screen. A single point.  
   _“There is nothing. Click to think.”_

2. **The First Principle**  
   The *Form* card creates the first hex.  
   _“This is a Principle. That which exists now has shape.”_

3. **New Ideas**  
   The player adds new cards.  
   _“Each thought creates a world. Each decision changes it.”_

4. **Memory of the World**  
   A tendency bar appears.  
   _“The world remembers your decisions.”_

5. **Manifestation**  
   The **Echo** card manifests.  
   _“That which you created begins to act.”_

6. **Motion and Reaction**  
   Colors pulse; hexes interact.  
   _“The world lives. Observe it.”_

7. **Revelation**  
   The screen slows; the system reveals your archetype.  
   _“Consciousness has reached its boundary.”_

---

<div align="center">

![Tutorial Flow](docs/tutorial_flow.png)

</div>

---

## ⚙️ Project Structure (Bevy ECS)

| System | Description |
|:--------|:-------------|
| `creation_system` | Interprets Idea Cards, creates Principles and hexes |
| `manifestation_system` | Activates entities (Manifestations) |
| `world_flow_system` | Handles cyclical world updates |
| `observation_system` | Tracks world metrics and balance |
| `revelation_system` | Evaluates and displays the final state |

> Each `Principle` is a plugin implementing the `PrincipleBehavior` trait —  
> allowing modular expansion of the world’s ontology.

---

## 💬 Narrative / UI Quotes

> 💭 “Each thought creates a Principle. Each Principle creates you.”  
> 💭 “The world remembers your decisions.”  
> 💭 “Do not seek victory. Seek meaning.”  
> 💭 “The world breathes — listen to it.”  
> 💭 “Your existence has consequence.”  

---

## 🧩 Principle Icons (for UI)

| Principle | Icon | Color |
|:--|:--:|:--|
| Form | 🔷 | `#5BA4FF` |
| Time | 🕰️ | `#A874FF` |
| Entropy | ⚡ | `#D13B3B` |
| Symmetry | 🪞 | `#4BD86B` |
| Memory | 🧠 | `#FFDE6A` |
| Rhythm | 🎵 | `#F9A04E` |
| Identity | ⚪ | `#D1D1D1` |
| Change | ♻️ | *dynamic gradient* |

---

## 🧱 Design Philosophy

> “You do not control. You do not fight. You do not score.  
> You create. You influence. You are reflected in what becomes.”

Each session is a new world.  
Each world — a story about meaning.  
Each decision — a question the world answers through you.

---

## ✨ Vision and Development

An **open-source** project built in **Rust + Bevy**.  
Includes an **open API** for modding:  
add new *Principles*, *Manifestations*, and *Archetypes*.

> “The world was not designed.  
> It was imagined.”

---

<div align="center">

**GENESIS PROTOCOL**  

Concept & Core System by [@mm4cN](https://github.com/mm4cN)  
Design, Development & Philosophy by the Consciousness Collective 🌐  


“The public version of Genesis Protocol is licensed under CC BY-NC-SA 4.0.
The author reserves the right to publish commercial editions under separate terms.”

![Footer](docs/footer_signature.png)

</div>

