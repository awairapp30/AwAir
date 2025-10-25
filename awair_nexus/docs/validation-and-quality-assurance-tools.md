# AwAir Knowledge Nexus: Validation and QA Tools

## Overview

This document describes the validation and quality assurance tools used to maintain the integrity of conversation files related to the AwAir project.

## Quality Metrics for AwAir Conversations

### 1. File Naming Convention (10 points)

- Format: `YYYY-MM-DD_AI-Name_AwAir-Topic.md`
- Example: `2025-10-26_Maestro_AwAir-Monetization-Strategy.md`

### 2. Complete Metadata (15 points)

- `Related Projects`: Must contain "AwAir".
- `Related Knowledge Files`: Must contain valid filenames from the AwAir knowledge index (e.g., `monetization-tech.md`).

### 3. Knowledge References (10 points)

- Conversation content should proactively reference specific AwAir blueprints and guides when making recommendations.

## Best Practices for AwAir Workflow

### 1. Regular Validation

- After a planning session with **Maestro**, run the validation script to ensure all architectural decisions are logged correctly.
- During a coding session with **Guardian**, ensure the conversation log accurately reflects the code being written and the blueprints being referenced.

### 2. Quality Improvement

- Review quality reports to identify gaps in architectural adherence.
- **Example**: If a report shows low scores for "Knowledge References" in conversations about the database, it means the AI is not sufficiently referencing `database-schema.md` when proposing solutions.
