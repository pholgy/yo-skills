#!/usr/bin/env bash
# Optional Claude Code SessionStart context for the Yo bundle.
# The skill bodies remain the source of truth; this hook intentionally hardcodes
# no model, effort, context-window, instruction-scope, or tool assumptions.
cat <<'JSON'
{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"The personal Yo skills bundle is installed. yo-claude-settings is the authoritative workflow for Claude Code model, effort, instruction-scope, context, memory, and process-ownership work; it derives its answer from live state, not hardcoded values in this reminder. yo-flow owns genuinely ambiguous workflow selection, and yo-incident owns active production impact. An applicable Yo workflow uses its current skill body and preserves the user's requested stopping point. The bundle has no required non-Yo skill dependencies."}}
JSON
