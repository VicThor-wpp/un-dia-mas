# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

La Llama is a narrative game written in Ink (Inkle Studios' scripting language) about labor precarity and neighborhood solidarity in Uruguay. The story follows a worker who gets fired on Wednesday and must decide whether to connect with community support networks.

## Build Commands

```bash
# Compile Ink to JSON for web runtime
inklecate -o la_llama.json prototype/ink/main.ink

# Test compilation (check for errors)
inklecate prototype/ink/main.ink
```

## Architecture

### Modular Tunnel Pattern

The codebase uses Ink's tunnel pattern for modularity. Files in `dias/` handle routing, while actual scenes live in `ubicaciones/` and `personajes/`:

```ink
// Caller (dias/lunes.ink)
-> casa_despertar ->      // Call tunnel
-> lunes_siguiente        // Returns here

// Module (ubicaciones/casa.ink)
=== casa_despertar ===
// Scene content
->->                      // Return to caller
```

### Variable Centralization

**All VAR declarations must be in `variables.ink` or `mecanicas/`**. Declaring VAR in other modules causes duplication errors at compile time.

### File Responsibilities

| Directory | Purpose |
|-----------|---------|
| `mecanicas/` | Game systems (dice, resources) - functions only |
| `ubicaciones/` | Reusable scenes by physical location |
| `personajes/` | NPC dialogues, encounters, night fragments |
| `dias/` | Day routing - calls tunnels, handles flow |
| `finales/` | End states based on accumulated variables |

### Key Game State Variables

- `dia_actual` (1-7): Current day
- `tiene_laburo` (bool): False after Wednesday despido
- `energia` (0-5): Daily action capacity
- `conexion` (0-10): Community integration
- `la_llama` (0-10): Collective hope
- `vinculo`: Randomly assigned NPC relationship ("sofia", "elena", "diego", "marcos")

### Dice System

```ink
// Basic roll
d6()

// Check with modifier vs difficulty
// Returns: 2=critical, 1=success, 0=fail, -1=fumble
chequeo(modificador, dificultad)

// Result stored in ultima_tirada for conditional branching
```

### Resource Functions

Use helper functions instead of direct manipulation:
- `subir_conexion(n)` / `bajar_conexion(n)`
- `subir_dignidad(n)` / `bajar_dignidad(n)`
- `subir_llama(n)` / `bajar_llama(n)`
- `gastar_energia(n)` - returns false if insufficient

## Common Patterns

### Conditional by game phase
```ink
{tiene_laburo: /* before firing */ }
{dia_actual >= 4: /* after Wednesday */ }
```

### NPC relationship checks
```ink
{sofia_relacion >= 4: /* friendly */ }
{vinculo == "sofia": /* special bond */ }
```

## Language

The game uses Uruguayan Spanish vocabulary:
- **bondi** = bus (not "micro")
- **laburo** = work
- **olla popular** = community soup kitchen
- **pibe/a** = kid
