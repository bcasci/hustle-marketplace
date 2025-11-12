---
name: optimize-prompt
description: Optimizes free-form prompt text using strategic constraints and proven prompting patterns
argument-hint: [prompt-text] [additional-instructions]
---

# optimize-prompt

Execute this 3-step workflow completely. Each step produces input for the next:

**WORKFLOW:**

1. CAPTURE:

   - Prompt text to optimize: `$1` → original_prompt
   - Additional instructions (optional): `$2` → extra_constraints
   - If $2 is empty, set extra_constraints = "none"

2. OPTIMIZE: Run your prompt-architecting skill → skill_output

   - Primary task: Optimize original_prompt
   - Additional constraints: Apply extra_constraints (if provided)
   - Pass extra_constraints as additional context to influence optimization strategy
     (Skill will return: Analysis, Selected Strategies, Optimized Prompt, Constraints Applied)
     → IMMEDIATELY extract "Optimized Prompt" section → new_instructions
     → IMMEDIATELY proceed to Step 3 WITH new_instructions

3. EXECUTE: Follow new_instructions as if the user had typed them directly
   - The "Optimized Prompt" section contains executable instructions (not documentation)
   - Execute those instructions completely, even if they describe multi-step workflows
   - If optimized prompt says "do X then Y then Z" → actually do X, Y, and Z
   - Complete execution before returning results

**EXECUTION RULES:**

- Complete ALL 3 steps without stopping
- Step 2 skill execution is NOT the final deliverable
- Task incomplete until step 3 completes
- Each step's output feeds the next - do not stop early

## Important Rules

- ALWAYS use prompt-architecting skill (never optimize manually)
- Output BOTH original and optimized versions for comparison
- Include brief explanation of strategies applied and what changed
- Preserve user's core intent - only improve clarity and reduce bloat
- This command is for inline text optimization (for files, use /optimize-prompt-file)
