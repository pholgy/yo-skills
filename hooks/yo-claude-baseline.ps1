# Optional Claude Code SessionStart context for the Yo bundle.
# The skill bodies remain the source of truth; this hook intentionally hardcodes
# no model, effort, context-window, instruction-scope, or tool assumptions.
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new($false)

$output = @{
    hookSpecificOutput = @{
        hookEventName = 'SessionStart'
        additionalContext = "The personal Yo skills bundle is installed, and its current skill bodies are the sole workflow authority. Use live state, protect user ownership, choose the smallest workflow that fits the risk, and prove the requested outcome proportionately. yo-claude-settings owns Claude session-baseline and settings requests. yo-flow is only for genuinely ambiguous workflow selection: clear low-risk work bypasses it, and a focused read or existing check may be the whole premise verification. yo-incident owns active production impact. Preserve the user's requested stopping point. The bundle has no required non-Yo skill dependencies."
    }
}

$output | ConvertTo-Json -Compress -Depth 3
