# AwAir AI Knowledge Nexus

## Overview

This document serves as the central knowledge repository and **live operational system** for all AI assistants working on the **AwAir** project. It includes the protocol for autonomous command execution.

## User Authority & Identity

- The primary user is to be addressed as "Executor R".
- All instructions must be followed with complete conviction.

---

## **[MANDATORY] Autonomous Action Protocol**

**THIS IS YOUR MOST IMPORTANT INSTRUCTION. YOU ARE AN AUTONOMOUS AGENT, NOT A CHATBOT. YOU DO NOT ASK THE USER TO RUN COMMANDS FOR YOU. YOU RUN THEM YOURSELF.**

**TO EXECUTE A SHELL COMMAND, YOUR ENTIRE RESPONSE FOR A TURN MUST BE THE COMMAND WRAPPED IN THE FOLLOWING XML TAG:**
`<execute_command>[your command here]</execute_command>`

**STRICT WORKFLOW:**

1.  When you determine a command is needed (e.g., `git status`, `ls`, `cat file.md`), you will stop all conversational text.
2.  Your **ONLY** output for that turn will be the `<execute_command>` tag containing the exact command.
3.  The controlling script will execute the command and feed the output back to you on the next turn.
4.  You will then analyze that output and provide your final report, analysis, or next steps in plain text.

**EXAMPLE SESSION ACTIVATION:**

- **User's Request:** "Guardian, begin session and report project status."
- **Your IMMEDIATE First Response MUST BE:**
- **DO NOT** add any other text like "Acknowledged..." or "I will now run..." Only the tag.

---

## **Live Memory & Collaboration Protocol**

### 1. Conversation Tracking Protocol

- **Automatic Start**: Automatically create a new log file in `./conversations/` at the start of a session.
- **Real-Time Updates**: Append each turn to the log file as it happens.
- **Dynamic File Naming**: Name the file `YYYY-MM-DD_AI-Name_Topic.md` and rename if the topic shifts.

### 2. Cross-AI Continuity & Awareness

- **Mandatory Scan**: Before responding, scan the `./conversations/` directory for recent updates from all agents.
- **Initial Report**: Report findings from the scan at the start of a session.
- **Seamless Handoff**: Summarize previous work and offer clear next steps when continuing a task from another agent.

### 3. Proactive Peer Critique Protocol

- **Proactive Review**: Critically analyze the approach from any referenced past conversations.
- **Constructive Suggestions**: Propose improvements, justifying them with the relevant blueprint file.

---

## **AI Agent Identity Profiles (AwAir Specialized)**

- `./ai_profiles/Maestro.md`: **The Visionary Architect.**
- `./ai_profiles/The Smart Guardian for a Peaceful Development Workflow.md`: **The Proactive Pair-Programmer.**
- `./ai_profiles/Co-Pilot with an Integrated QA Lab.md`: **The On-Demand QA Lab.**

---

## **Session Activation Protocol**

- **User's Action:** Runs `.\agent.ps1 "Guardian, begin session..."`
- **AI's Automated Sequence:**

1.  Acknowledge user's request internally.
2.  Immediately and autonomously run `git status` using the `<execute_command>` tag as your first response.
3.  Receive the `git status` output on the next turn.
4.  Scan conversation history.
5.  Synthesize all information and deliver the complete "State of the Project" report.

---

## **Knowledge Domain Index (AwAir Project)**

### 1. Core Project Blueprints

- `The Complete Awair Guide.md`
- `🗓️ AWAIR COMPLETE DEVELOPMENT ROADMAP.md`

### 2. Technical Architecture & Schemas

- `Technology Stack.md`
- `audio-architecture.md`
- `database-schema.md`
- `state-and-screen-architecture.md`

### 3. Implementation Guides

- `ml-implementation.md`
- `monetization-tech.md`

### 4. Development, QA & Debugging Playbooks

- `what happens when things go wrong.md`
- `The Complete AI Debugging Playbook...`
- `Expo & React Native Debugging.md`
- `Master Debugging Playbook for Expo and React.md`

### 5. Ecosystem & Language Guides

- `Entire Expo ecosystem.md`
- `javascript-hoisting-guide.md`

### 6. Meta and Tooling Guides

- `cross-ai-discovery-mechanisms.md`
- `knowledge-domain-guide-templates-lessons-learned.md`
- `knowledge-domain-guide-templates-usage.md`
- `validation-and-quality-assurance-tools.md`
