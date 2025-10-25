# Cross-AI Discovery Mechanisms for AwAir

## Overview

This document describes the cross-AI discovery mechanisms for the AwAir AI Knowledge Nexus. These tools enable AIs to find, reference, and collaborate on conversations across different agents and topics specific to AwAir's development.

## Available Scripts

### 1. Conversation Search Scripts

**Purpose**: Find conversations based on various criteria related to the AwAir project.

**Usage**:

```powershell
# Find conversations about the TapGame implementation
.\find_conversations.ps1 -Topic "TapGame"

# Find conversations where the Guardian persona was used
.\find_conversations.ps1 -AI "Guardian" -Project "AwAir"
```

2. Conversation Summary Scripts

Purpose: Generate concise summaries of AwAir development conversations.

Usage:

# Summarize the audio architecture discussion

.\summarize_conversation.ps1 "2025-10-26_Maestro_AwAir-Audio-Architecture-Planning.md"

3. Peer Review Scripts

Purpose: Extract key insights and recommendations from AwAir conversations.

Usage:

# Review a coding session on the state management implementation

.\peer_review_conversation.ps1 "2025-10-27_Guardian_State-Context-Refactoring.md"

Output Example: "The implementation of AudioContext is functional. Suggestion: Refactor to split state and actions to prevent unnecessary re-renders, as outlined in state-and-screen-architecture.md."
Best Practices for AwAir

    Use specific tags like #react-native, #firebase, #revenuecat, #tflite, #audio.

    Reference specific AwAir document filenames (e.g., database-schema.md) in conversation metadata.

--- END OF FILE ---

#### **File 2: `knowledge-domain-guide-templates-lessons-learned.md`**

--- START OF FILE ---

```markdown
# AwAir Knowledge Guides: Usage Summary and Lessons Learned

## Overview

This document summarizes our experience implementing the AwAir knowledge guides and provides insights for future documentation within the project.

## Guide Implementation Summary

### Programming Language Guide

**Implementation**: JavaScript/React Native & Expo (`Entire Expo ecosystem.md`, `javascript-hoisting-guide.md`)

- **Strengths**: Comprehensive coverage of the core framework and common language pitfalls.
- **Lessons**: The debugging playbooks are critical companions to these guides.

### Development Environment Guide

**Implementation**: VS Code Setup (`what happens when things go wrong.md` - Section 1)

- **Strengths**: Directly integrates ESLint and Prettier, enforcing consistency for the AwAir codebase.
- **Lessons**: Having this in the operational blueprint is more effective than a separate file.

### Project Structure & Architecture Guide

**Implementation**: `state-and-screen-architecture.md`

- **Strengths**: Clearly defines the Context API hierarchy and data flow for all 8 screens.
- **Lessons**: This document is the cornerstone for preventing prop-drilling and state management issues.

### Service Integration Guide

**Implementation**: `monetization-tech.md` (RevenueCat) and `ml-implementation.md` (TensorFlow)

- **Strengths**: Provide exact implementation steps, including code snippets and setup instructions.
- **Lessons**: These technical guides significantly reduce ramp-up time for complex integrations.

## Best Practices for Future AwAir Documentation

- **Integrate Blueprints**: All new guides must align with `The Complete Awair Guide.md` and the development roadmap.
- **Actionable Code**: Prioritize working, copy-pasteable code snippets that are relevant to the AwAir stack.
- **Cross-Reference Heavily**: Link back to the core schemas (`database-schema.md`, `audio-architecture.md`) whenever applicable.
```
