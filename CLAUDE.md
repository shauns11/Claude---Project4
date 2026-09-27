###############################
#CLAUDE.md (Project4)
###############################
  
# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Purpose

Execute Stata do-files from Visual Studio Code

## File Paths

- Working directory: `C:\CLAUDE\Projects\Project4`
- Stata executable: `C:\Program Files\StataNow19\StataMP-64.exe`
- Do-files: `code\`
- Log files, tables, figures: `output\`
- Datasets: `data\`

## Running a Do-File

The `/e` flag runs Stata in batch (non-interactive) mode. Replace the filename as needed:

```powershell
& "C:\Program Files\StataNow19\StataMP-64.exe" /e do "C:\CLAUDE\Projects\Project4\code\survey_data.do"
```

To run all do-files in `code\` in order 

```powershell
Get-ChildItem "C:\CLAUDE\Projects\Project4\code\*.do" | Sort-Object Name | ForEach-Object { & "C:\Program Files\StataNow19\StataMP-64.exe" /e do $_.FullName }
```

> **Note:** Stata's `/e` batch mode also creates a secondary `.log` file named after the do-file in the directory where the command is invoked (e.g., `survey_data.log` in the working directory). This is separate from the explicit log opened inside the do-file. These root-level log files are expected artifacts.

## Do-File Template

Every do-file must follow this structure — open a log file at the top (using `replace`), after estimation, capture date and time, display them, then close the log file:

```stata
log using "output\Do_File_Name.log", replace

* ... commands ...

local date `c(current_date)'
local time `c(current_time)'
display _newline "Run `date' at `time'"

log close
```

## Conventions

- Log file naming: `Do_File_Name.log` 
- Save do-files to `code\`, save log files to `output\`

## Git and GitHub

Remote: `https://github.com/shauns11/Claude---Project4.git` (branch `main`). The GitHub CLI (`gh`) is not installed, so use plain `git` and the GitHub website.

### First-time setup (new project)

1. Create `.gitignore` in the project root **before** the first commit, so ignored files are never committed:

```text
# Secondary logs created by Stata batch mode (/e) in the project root
/*.log

# Stata datasets (anywhere in the project)
*.dta
```

2. Initialise the repository, check what will and won't be committed, then commit:

```powershell
git init -b main
git add .
git status --short             # files to be committed
git status --short --ignored   # lines starting "!!" are ignored (e.g. 01.log)
git commit -m "Initial commit"
```

3. Create an **empty** repository on github.com (no README, .gitignore or licence) and choose Public or Private.
4. Before pushing, confirm the remote exists and is empty. `git ls-remote` returns nothing for an empty repo and "Repository not found" if the URL is wrong, deleted or private without access:

```powershell
git ls-remote https://github.com/shauns11/Claude---Project4.git
```

5. Add the remote and push `main`:

```powershell
git remote add origin https://github.com/shauns11/Claude---Project4.git
git push -u origin main
git status -sb                 # should show: ## main...origin/main
```

6. Update the `Remote:` line at the top of this section.

Notes:
- Never use `git push --force` against a repository that already has history unless you intend to permanently replace it.
- Warnings like "LF will be replaced by CRLF" are Windows line-ending notices and can be ignored.

### Day-to-day

```powershell
git status                 # see what changed
git add .                  # stage changes
git commit -m "Message"    # commit
git push                   # upload to GitHub
```

### What is tracked

- Tracked: `code\` (do-files), `output\` (logs, tables, figures), `CLAUDE.md`, `.gitignore`
- Ignored (see `.gitignore`):
  - `/*.log` — root-level logs created by Stata batch mode
  - `*.dta` — Stata datasets, anywhere in the project

## Stata Skills

Comprehensive Stata reference files are stored locally at:

- [.claude/skills/stata/SKILL.md](.claude/skills/stata/SKILL.md) — Stata syntax, data management, econometrics, causal inference, graphics, Mata, and 20+ community packages (`reghdfe`, `estout`, `did`, `rdrobust`, etc.)
- [.claude/skills/stata-c-plugins/SKILL.md](.claude/skills/stata-c-plugins/SKILL.md) — C/C++ plugin development for Stata

When writing, debugging, or explaining Stata code, read the relevant SKILL.md first. Each file contains a routing table — follow it to load only the 1–3 reference files needed for the task. Reference files live alongside the SKILL.md in `references/` and `packages/` subdirectories.


