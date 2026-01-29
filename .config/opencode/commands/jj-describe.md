---
description: Create a summary of current changes
subtask: true
---

Write a commit description for the current changes in jj.

1. Run `jj diff` to see the current changes
2. Run `jj log -r @ -T description` to see the current description (if any)
3. Analyze the changes and write a concise, descriptive commit message
4. Write the description with `jj describe -m` command

Follow conventional commit style if appropriate (feat:, fix:, refactor:, etc.)
