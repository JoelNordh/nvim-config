-- Product-management note templates (markdown-only; loaded via LuaSnip's
-- from_lua loader, which maps this filename to the `markdown` filetype).
return {
  s("prd", {
    t({ "# PRD: " }), i(1, "Feature name"),
    t({ "", "", "## Problem", "" }),
    i(2, "What problem are we solving, and for whom?"),
    t({ "", "", "## Goals", "- " }),
    i(3, "Goal 1"),
    t({ "", "", "## Non-goals", "- " }),
    i(4, "Explicitly out of scope"),
    t({ "", "", "## Success metrics", "- " }),
    i(5, "How will we know this worked?"),
    t({ "", "", "## Proposed solution", "" }),
    i(6, "High-level approach"),
    t({ "", "", "## Open questions", "- " }),
    i(0, "Anything unresolved"),
  }),

  s("meeting", {
    t({ "# Meeting: " }), i(1, "Title"),
    t({ "", "" }),
    t("Date: "), f(function() return os.date("%Y-%m-%d") end),
    t({ "", "Attendees: " }), i(2),
    t({ "", "", "## Agenda", "- " }),
    i(3),
    t({ "", "", "## Notes", "" }),
    i(4),
    t({ "", "", "## Action items", "- [ ] " }),
    i(0),
  }),

  s("decision", {
    t({ "# Decision: " }), i(1, "Title"),
    t({ "", "" }),
    t("Date: "), f(function() return os.date("%Y-%m-%d") end),
    t({ "", "Status: " }), i(2, "Proposed"),
    t({ "", "", "## Context", "" }),
    i(3, "What situation led to this decision being needed?"),
    t({ "", "", "## Decision", "" }),
    i(4, "What are we doing?"),
    t({ "", "", "## Consequences", "- " }),
    i(0, "Trade-offs and follow-up work"),
  }),

  s("1pager", {
    t({ "# " }), i(1, "Title"),
    t({ "", "", "## Summary", "" }),
    i(2, "One paragraph: what, why, impact"),
    t({ "", "", "## Background", "" }),
    i(3),
    t({ "", "", "## Recommendation", "" }),
    i(4),
    t({ "", "", "## Risks", "- " }),
    i(0),
  }),

  s("standup", {
    t("Yesterday: "), i(1),
    t({ "", "Today: " }), i(2),
    t({ "", "Blockers: " }), i(0, "None"),
  }),
}
