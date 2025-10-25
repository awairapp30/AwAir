# AwAir Knowledge Domain Guides: Usage Guide

## Overview

This document provides guidelines for effectively using the knowledge domain guides within the AwAir AI Knowledge Nexus.

## Guide Selection for AwAir Tasks

- **Implementing a new screen?** Start with `state-and-screen-architecture.md` and `The Complete Awair Guide.md` (for UI/UX details).
- **Working with audio?** The primary reference is `audio-architecture.md`.
- **Writing a Firestore query?** `database-schema.md` is the source of truth for all data structures.
- **A bug occurred?** Follow the workflow in `Master Debugging Playbook for Expo and React.md`.
- **Unsure of the technology?** Consult `Technology Stack.md`.

## Content Creation Guidelines

- **Consistency**: All new documentation must be consistent with the terminology and architecture defined in the master blueprints.
- **Technical Accuracy**: Code examples must be compatible with the versions of Expo, React Native, and Firebase specified in `Technology Stack.md`.
- **Completeness**: Any new feature documentation must cover its impact on existing schemas, state, and the user flow.

## Integration with the AwAir Nexus

- **Conversation References**: When discussing a task, AIs must reference the specific AwAir guides that govern it. (e.g., "According to `audio-architecture.md`, Level 1 tracks must be bundled in the APK.")
- **Search and Discovery**: Use tags like `#homescreen`, `#tapgame`, `#soundform` to categorize conversations for easy discovery.
