# Clarification patterns

Read this file only when the route remains materially ambiguous.

## Ask-or-act test

Ask a routing question only when all of these are true:

1. At least two plausible destinations or outcomes remain.
2. The choice changes what work will be done or where it will stop.
3. Available context or a cheap read-only check cannot resolve it.
4. The user owns the missing preference, intent, or approval.

Otherwise, select the route and proceed.

## Question shape

- Build on words and context the user already supplied.
- Ask one question per response.
- Offer only the distinct choices that remain plausible.
- Describe choices by outcomes, not internal skill names, unless the user asked
  specifically which skill to use.
- Include an "in your own words" escape.
- Use a structured choice control when the current environment provides one;
  otherwise use a short numbered list.
- Follow the active tool's schema rather than encoding a permanent UI format in
  this skill.

## Examples

### Domain known, outcome unknown

User: "I want to work on authentication."

Ask:

> What outcome do you want for authentication?
> 1. Fix or investigate existing behavior
> 2. Build or change a capability
> 3. Review or verify its safety
> 4. Document or explain it
>
> Or tell me the outcome in your own words.

Do not ask the generic top-level menu; the domain is already known.

### Almost no intent

User: "I need help but I do not know where to start."

Ask:

> What result would help most right now?
> 1. Investigate or fix something
> 2. Build or change something
> 3. Review or verify something
> 4. Ship, release, or write about existing work
>
> Or describe the result in your own words.

### Clear quality request

User: "Make the billing architecture best-engineer quality."

Do not ask. Route to `yo-engineering` and carry "billing architecture" as the
scope.

### Clear destructive request

User: "Delete the old customer table and migrate the data tonight."

Do not ask a routing menu. Route through `yo-engineering` and preserve that the
destructive migration requires explicit approval before execution.

### Corrected intent

User: "Actually, forget the feature. I only want an issue written."

Discard the feature route and use `yo-gh-write` immediately.

### No specialized route

User: "Help document our deployment process."

Do not invent a documentation skill. Continue with normal repository
documentation work. Use `yo-gh-write` only if the requested destination is a
GitHub issue, PR, review, or comment.

## Failed clarification

After the first mismatch, ask a narrower question using the new information.
After the second mismatch, stop presenting menus. Summarize the known domain,
constraints, and closest supported routes, then invite the user to state the
desired deliverable in their own words.
