# Entity-Relationship Diagram

Generated directly from the backend's SQLModel table definitions (`../hr-leave-management/backend/app/models.py` and `backend/app/leave_models/*.py`) — not hand-drawn, so it stays accurate to the actual schema. Covers the HR Leave Management domain; the FastAPI template's leftover `Item`/`User.items` demo table is intentionally omitted (unused scaffolding, not part of this project's business domain).

## Diagram

```mermaid
erDiagram
    USER ||--o{ TEAM : "creates (owner_id)"
    USER ||--o{ TEAM : "leads (team_owner_id)"
    TEAM ||--o{ USER : "has members (team_id)"
    USER ||--o{ LEAVE_TYPE : "creates (owner_id)"
    USER ||--o{ PUBLIC_HOLIDAY : "creates (owner_id)"
    USER ||--o{ POLICY : "creates (owner_id)"
    USER ||--o{ LEAVE_BALANCE : "owns (owner_id)"
    LEAVE_TYPE ||--o{ LEAVE_BALANCE : "tracked for"
    USER ||--o{ LEAVE_REQUEST : "submits (owner_id)"
    USER ||--o{ LEAVE_REQUEST : "approves (approver_id)"
    TEAM ||--o{ LEAVE_REQUEST : "scoped to"
    LEAVE_TYPE ||--o{ LEAVE_REQUEST : "typed as"
    USER ||--o{ LEAVE_PLAN_REQUEST : "submits (owner_id)"
    USER ||--o{ LEAVE_PLAN_REQUEST : "approves (approver_id)"
    TEAM ||--o{ LEAVE_PLAN_REQUEST : "scoped to"
    LEAVE_TYPE ||--o{ LEAVE_PLAN_REQUEST : "typed as"
    LEAVE_PLAN_REQUEST ||--o{ LEAVE_PLAN_DETAIL : "has dates"
    USER ||--o{ NOTIFICATION : "receives (recipient_id)"
    USER ||--o{ NOTIFICATION : "triggers (actor_id)"
    USER ||--o{ AUDIT_LOG : "performs (actor_id)"

    USER {
        uuid id PK
        string email UK
        string username UK "nullable, admin-set"
        string full_name
        string phone_number "nullable"
        bool is_active
        bool is_superuser
        uuid team_id FK "nullable"
        string hashed_password
    }

    TEAM {
        uuid id PK
        string name
        string description "nullable"
        uuid owner_id FK "creator (admin)"
        uuid team_owner_id FK "approver / line manager"
        bool is_active
    }

    LEAVE_TYPE {
        uuid id PK
        string code
        string name
        int entitlement
        string description "nullable"
        bool is_allow_plan
        bool is_active
        uuid owner_id FK
    }

    PUBLIC_HOLIDAY {
        uuid id PK
        string date "YYYY-MM-DD string, not a date column"
        string name
        string description "nullable"
        uuid owner_id FK
    }

    POLICY {
        uuid id PK
        string code "weekday / team_workload / bridge_holiday"
        string name
        string operation "nullable; in, greater-than, etc, free-form"
        string value
        float score "nullable"
        string description "nullable"
        bool is_active
        uuid owner_id FK
    }

    LEAVE_BALANCE {
        uuid id PK
        string year "4-char string"
        float balance
        float taken_balance
        uuid owner_id FK
        uuid leave_type_id FK
    }

    LEAVE_REQUEST {
        uuid id PK
        date start_date
        date end_date
        string description "nullable"
        string year
        float amount
        string status "draft / pending / approved / rejected"
        datetime requested_at
        datetime submitted_at "nullable"
        datetime approval_at "nullable"
        uuid owner_id FK
        uuid approver_id FK "nullable"
        uuid team_id FK
        uuid leave_type_id FK
    }

    LEAVE_PLAN_REQUEST {
        uuid id PK
        string description "nullable"
        string year
        float amount
        string status "draft / pending / approved / rejected"
        datetime requested_at
        datetime submitted_at "nullable"
        datetime approval_at "nullable"
        uuid owner_id FK
        uuid approver_id FK "nullable"
        uuid team_id FK
        uuid leave_type_id FK
    }

    LEAVE_PLAN_DETAIL {
        uuid id PK
        date leave_date
        uuid leave_plan_id FK
    }

    NOTIFICATION {
        uuid id PK
        string event_type
        string entity_type "leave_request / leave_plan_request"
        uuid entity_id
        string message
        bool is_read
        datetime created_at
        uuid recipient_id FK
        uuid actor_id FK "nullable"
    }

    AUDIT_LOG {
        uuid id PK
        string action "create / update / delete / submit / approve / reject"
        string entity_type "user, team, leave_type, policy, etc"
        uuid entity_id
        string summary "human-readable description"
        datetime created_at
        uuid actor_id FK "nullable, SET NULL on user delete"
    }
```

## Notes

- **`owner_id` on `LeaveType`/`PublicHoliday`/`Policy`/`LeaveBalance`** means "created/managed by this admin user," not "belongs to this employee" — these are master-data tables. `LeaveBalance.owner_id` is the exception: there it genuinely means "this employee's balance."
- **`Team` has two distinct FKs to `User`**: `owner_id` (who created the team record, always an admin) and `team_owner_id` (the line approver whose pending-approvals queue and Approvals nav entry are driven by this field — see `CLAUDE.md`'s "team owner" heuristic). They are usually, but not necessarily, the same person.
- **`LeaveRequest`/`LeavePlanRequest.approver_id`** is nullable and only populated once a request is submitted (an employee with no team, or a team with no `team_owner_id`, can have a request stuck without an approver — surfaced client-side as a friendly error, see `tasks/plan.md` Task 4.3).
- **`available_balance`** on `LeaveBalance` is a computed property (`balance - taken_balance`), not a stored column — shown here because it's part of the API contract (`LeaveBalancePublic`), not because it's a DB field.
- **`PublicHoliday.date`** is a plain string column (`"YYYY-MM-DD"`), not a SQL date type — a deliberate backend inconsistency also called out in `CLAUDE.md`'s "Backend contract quirks" section.
- **`AuditLog`** is written internally (by `AuditService`, as a side effect of the mutations it describes) — there is no create/update/delete endpoint for it, only `GET /audit-logs/` (superuser-only). `actor_id` is nullable with `ON DELETE SET NULL` so an entry survives even if the acting user's account is later deleted; `summary` captures a human-readable description at write time so the trail stays legible even then.
- Not shown: the FastAPI template's original `Item`/`User.items` table — present in the codebase as unused scaffolding from the starter template, not part of the HR Leave domain.

## Source of truth

Regenerate this by re-reading the model files directly if the schema changes — there is no automated diagram-generation step wired into either repo's build.
