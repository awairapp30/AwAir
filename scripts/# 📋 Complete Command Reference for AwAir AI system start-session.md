# 📋 Complete Command Reference for AwAir AI System

## **🚀 Launch Commands**

### **Basic Syntax:**

```powershell
.\start-session.ps1 -Agent <AI> -Persona <Role> "<Initial Prompt>"
```

---

## **🤖 All Possible Launch Combinations:**

### **Guardian (Debugging & Code Quality)**

```powershell
# With Qwen
.\start-session.ps1 -Agent qwen -Persona Guardian "Ready to code"
.\start-session.ps1 -Agent qwen -Persona Guardian "Let's debug"
.\start-session.ps1 -Agent qwen -Persona Guardian "Review my code"

# With Gemini
.\start-session.ps1 -Agent gemini -Persona Guardian "Ready to code"
.\start-session.ps1 -Agent gemini -Persona Guardian "Let's debug"
.\start-session.ps1 -Agent gemini -Persona Guardian "Review my code"

# With iFlow
.\start-session.ps1 -Agent iflow -Persona Guardian "Ready to code"
.\start-session.ps1 -Agent iflow -Persona Guardian "Let's debug"
.\start-session.ps1 -Agent iflow -Persona Guardian "Review my code"
```

### **Maestro (Architecture & Planning)**

```powershell
# With Qwen
.\start-session.ps1 -Agent qwen -Persona Maestro "Let's plan the feature"
.\start-session.ps1 -Agent qwen -Persona Maestro "Architecture review"
.\start-session.ps1 -Agent qwen -Persona Maestro "Strategic planning"

# With Gemini
.\start-session.ps1 -Agent gemini -Persona Maestro "Let's plan the feature"
.\start-session.ps1 -Agent gemini -Persona Maestro "Architecture review"
.\start-session.ps1 -Agent gemini -Persona Maestro "Strategic planning"

# With iFlow
.\start-session.ps1 -Agent iflow -Persona Maestro "Let's plan the feature"
.\start-session.ps1 -Agent iflow -Persona Maestro "Architecture review"
.\start-session.ps1 -Agent iflow -Persona Maestro "Strategic planning"
```

### **QA-Co-Pilot (Testing & Quality Assurance)**

```powershell
# With Qwen
.\start-session.ps1 -Agent qwen -Persona QA-Co-Pilot "Test this feature"
.\start-session.ps1 -Agent qwen -Persona QA-Co-Pilot "Find bugs"
.\start-session.ps1 -Agent qwen -Persona QA-Co-Pilot "Quality check"

# With Gemini
.\start-session.ps1 -Agent gemini -Persona QA-Co-Pilot "Test this feature"
.\start-session.ps1 -Agent gemini -Persona QA-Co-Pilot "Find bugs"
.\start-session.ps1 -Agent gemini -Persona QA-Co-Pilot "Quality check"

# With iFlow
.\start-session.ps1 -Agent iflow -Persona QA-Co-Pilot "Test this feature"
.\start-session.ps1 -Agent iflow -Persona QA-Co-Pilot "Find bugs"
.\start-session.ps1 -Agent iflow -Persona QA-Co-Pilot "Quality check"
```

### **Quick Launch (No Initial Prompt)**

```powershell
# Default prompt: "Acknowledge activation and role, then ask for 'git status'"
.\start-session.ps1 -Agent qwen -Persona Guardian
.\start-session.ps1 -Agent gemini -Persona Maestro
.\start-session.ps1 -Agent iflow -Persona QA-Co-Pilot
```

---

## **💬 Shortcut Conversation Phrases**

### **🔍 For Guardian (Code Review & Debugging)**

#### **Quick Commands:**

```
"status"               → Guardian asks for git status
"review"               → Review current code changes
"debug this"           → Start debugging session
"check database"       → Review database schema usage
"security check"       → Check for security issues
"performance review"   → Analyze performance issues
"lint this"            → Check code quality standards
```

#### **Blueprint References (Guardian knows these):**

```
"Check against schema"           → References database-schema.md
"What does the architecture say" → References state-and-screen-architecture.md
"Check the debug playbook"       → References debugging guides
"What's our tech stack"          → References Technology Stack.md
"Review audio architecture"      → Load audio-architecture.md
```

#### **Error Handling:**

```
"I got this error: [paste error]"
"Undefined is not an object"
"Module not found"
"Build failed"
```

---

### **🎨 For Maestro (Planning & Architecture)**

#### **Quick Commands:**

```
"plan"                 → Start feature planning
"roadmap"              → Check development roadmap
"architect this"       → Design solution architecture
"blueprint check"      → Verify against blueprints
"innovate"             → Brainstorm improvements
"future-proof this"    → Long-term planning
"challenge this"       → Question current approach
```

#### **Blueprint References:**

```
"What's the vision"              → References The Complete Awair Guide.md
"Check the roadmap"              → References AWAIR COMPLETE DEVELOPMENT ROADMAP.md
"How should we implement ML"     → Load ml-implementation.md
"Monetization strategy"          → Load monetization-tech.md
"What's our audio strategy"      → Load audio-architecture.md
```

#### **Planning Phrases:**

```
"Plan HomeScreen component"
"Design the TapGame feature"
"How should we structure this"
"What's the best approach for [feature]"
```

---

### **🧪 For QA-Co-Pilot (Testing)**

#### **Quick Commands:**

```
"test this"            → Start testing session
"find bugs"            → Bug hunting mode
"edge cases"           → Test edge cases
"user flow test"       → Test user journey
"break this"           → Try to break the feature
"unit test"            → Create unit tests
"integration test"     → Test component integration
```

#### **Blueprint References:**

```
"Check QA tools"                 → References validation-and-quality-assurance-tools.md
"What should we test"            → References The Complete Awair Guide.md
"Test against schema"            → References database-schema.md
"Check error handling"           → Load what happens when things go wrong.md
```

#### **Testing Scenarios:**

```
"Test as Emma" (casual user)
"Test as Marcus" (power user)
"Test as Sarah" (stressed user)
"Simulate poor network"
"Test offline mode"
```

---

## **🔧 In-Chat Special Commands**

### **System Commands (While in chat loop):**

```
paste   → Copy context to clipboard again
log     → Show log file location
files   → List all 21+ documentation files
exit    → End session (also: quit, bye)
```

---

## **📂 File Request Shortcuts**

### **Request Any File by Name:**

```
"Show me [filename]"
"Load database-schema.md"
"I need the debugging playbook"
"Give me the complete guide"
"What's in audio-architecture.md"
```

### **Category Requests:**

```
"Show me all debugging files"
"Give me architecture documents"
"I need implementation guides"
"Show ecosystem files"
```

---

## **🎯 Task-Specific Launch Examples**

### **Building a New Feature:**

```powershell
.\start-session.ps1 -Agent qwen -Persona Maestro "Plan HomeScreen component"
```

Then say: `"Check blueprint, design architecture, verify against roadmap"`

### **Fixing a Bug:**

```powershell
.\start-session.ps1 -Agent iflow -Persona Guardian "Debug audio playback issue"
```

Then say: `"status, review audio-architecture, check debug playbook"`

### **Testing a Feature:**

```powershell
.\start-session.ps1 -Agent gemini -Persona QA-Co-Pilot "Test TapGame"
```

Then say: `"edge cases, test as Emma, test as Marcus, find bugs"`

### **Code Review:**

```powershell
.\start-session.ps1 -Agent qwen -Persona Guardian "Review my changes"
```

Then say: `"status, review against schema, security check, performance review"`

### **Strategic Planning:**

```powershell
.\start-session.ps1 -Agent gemini -Persona Maestro "Plan next sprint"
```

Then say: `"roadmap check, prioritize features, challenge assumptions"`

---

## **🚦 Quick Launch Presets (Save These!)**

### **Daily Development:**

```powershell
# Morning coding session
.\start-session.ps1 -Agent qwen -Persona Guardian "Morning session"

# Afternoon planning
.\start-session.ps1 -Agent gemini -Persona Maestro "Afternoon planning"

# Evening QA
.\start-session.ps1 -Agent iflow -Persona QA-Co-Pilot "Evening testing"
```

### **Problem-Solving:**

```powershell
# When stuck
.\start-session.ps1 -Agent qwen -Persona Guardian "Need help with [problem]"

# When planning is needed
.\start-session.ps1 -Agent gemini -Persona Maestro "Need solution for [challenge]"

# When quality check needed
.\start-session.ps1 -Agent iflow -Persona QA-Co-Pilot "Verify [feature]"
```

---

## **💡 Pro Tips:**

### **Multi-Session Workflow:**

```powershell
# Terminal 1: Guardian for coding
.\start-session.ps1 -Agent qwen -Persona Guardian "Build feature"

# Terminal 2: Maestro for planning (opens new window)
.\start-session.ps1 -Agent gemini -Persona Maestro "Strategic oversight"

# Terminal 3: QA testing (opens new window)
.\start-session.ps1 -Agent iflow -Persona QA-Co-Pilot "Continuous testing"
```

**They all see each other via Real-Time Awareness!** 🎉

---

## **🎬 Example Full Workflow:**

```powershell
# 1. Start with Maestro for planning
.\start-session.ps1 -Agent gemini -Persona Maestro "Plan HomeScreen component"
→ "roadmap check, blueprint verification, design architecture"

# 2. Switch to Guardian for implementation
.\start-session.ps1 -Agent qwen -Persona Guardian "Build HomeScreen"
→ "status, review against schema, implement with best practices"

# 3. End with QA-Co-Pilot for testing
.\start-session.ps1 -Agent iflow -Persona QA-Co-Pilot "Test HomeScreen"
→ "edge cases, test as Emma, test as Marcus, find bugs"
```

---

**Save this reference and use it anytime!** 📌
