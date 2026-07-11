# Search strategy

Choose the layers that can plausibly contain an observer. Start narrow, expand when the change crosses a boundary, and record where the search stopped.

## 1. Establish the authoritative surface

- Read the definition and its local control/data flow.
- Use language-aware definitions, references, implementations, overrides, imports, and exports when available.
- Inspect callers and callees far enough to identify the observable behavior, not merely the nearest syntax match.
- Note generated sources and whether their generator or generated output is authoritative.

## 2. Search textual and dynamic surfaces

Search the symbol and its serialized or configured values, including relevant case and naming variants. Plausible locations include:

- route names, CLI flags, environment variables, feature flags, and config keys;
- JSON, GraphQL, protobuf, SQL, templates, localization, reflection, and dependency injection;
- fixtures, snapshots, mocks, examples, documentation, dashboards, and runbooks;
- build, deployment, migration, and maintenance scripts;
- generated clients, schemas, registries, and code-generation inputs.

A raw text hit is a lead. Classify whether it defines, produces, consumes, validates, stores, forwards, documents, monitors, or merely mentions the behavior.

## 3. Trace contract and data boundaries

Check the surfaces relevant to the change:

- HTTP/RPC APIs, SDKs, webhooks, events, queues, and scheduled jobs;
- database columns and rows, JSON blobs, files, caches, search indexes, and user settings;
- audit records, analytics events, logs, metrics, alerts, and support tooling;
- other packages, services, repositories, mobile/desktop clients, integrations, and public documentation.

For versioned or deployed systems, reason about old/new readers and writers, rollback, partial rollout, delayed messages, stale caches, and retained data.

## 4. Use history when rationale matters

- Start with nearby comments, tests, and documentation.
- Use path or line history when behavior is surprising, workaround-like, security-sensitive, or likely to reflect a tradeoff.
- Follow the introducing or changing commit to its review, issue, or decision record when available.
- Treat authorship and commit messages as provenance. Confirm rationale against the actual diff and current behavior.

History can explain why a surface exists; it cannot prove that the old decision still fits today's requirements.

## 5. Locate sibling paths

Search for distinctive logic and conceptual equivalents:

- copied blocks or repeated conditions;
- sync/async and read/write variants;
- versioned endpoints, platform adapters, provider implementations, and fallback paths;
- retries, recovery paths, background processing, and administrative tools.

List material siblings even when they are deliberately excluded from the current change.

## 6. Find evidence and declare limits

- Locate focused, contract, integration, end-to-end, and transitive tests as appropriate.
- Run a pre-edit baseline when existing failure state or attribution matters.
- Record unavailable environments, inaccessible repositories, unknown external consumers, and generated or dynamic surfaces the tools could not resolve.

Use precise claims such as "no other observers found in repository X at revision Y across symbol, literal, schema, and test searches." Avoid the unbounded claim "nothing else uses this."
