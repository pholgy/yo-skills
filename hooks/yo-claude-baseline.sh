#!/usr/bin/env bash
# Optional Claude Code SessionStart context for the Yo bundle.
# The skill bodies remain the source of truth; this hook intentionally hardcodes
# no model, effort, context-window, instruction-scope, or tool assumptions.
cat <<'JSON'
{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"The personal Yo skills bundle is installed, and its current skill bodies are the sole workflow authority. Use live state, protect user ownership, and produce the smallest complete production-quality solution: direct, explainable, faithfully verified, and free of speculative moving parts. For defects, remove the cause, cover realistic same-cause paths, and add focused regression proof. Finish substantive work with a simplification pass. Choose the smallest workflow that fits the risk. yo-claude-settings owns Claude session-baseline and settings requests. yo-flow is only for genuinely ambiguous workflow selection; clear low-risk work bypasses it. yo-incident owns active production impact. Preserve the user's requested stopping point. The bundle has no required non-Yo skill dependencies."}}
JSON
