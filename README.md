# mini-iam-proto

Shared gRPC API contracts (`.proto`) for the `quangdd-mini-iam` project.
This is the single source of truth for inter-service APIs between
`auth-service`, `user-service`, `rbac-service`, and `api-gateway`.

## Layout

```
proto/mini_iam/
├── common/v1/common.proto   shared types (errors, audit meta)
├── auth/v1/auth.proto       Login, RefreshToken, IntrospectToken, Logout
├── user/v1/user.proto       CRUD users, credential lookup for auth-service
└── rbac/v1/rbac.proto       Authorize (called by api-gateway on every request)
```

## Why gRPC (and one deliberate exception)

Internal service-to-service traffic uses gRPC + protobuf: strict typed
contracts, low overhead, easy to evolve with `buf breaking` checks in CI.

**Exception — JWKS:** `auth-service` also exposes
`/.well-known/jwks.json` as plain HTTP/JSON (RFC 7517), *not* gRPC. External
JWT verifiers and third-party tooling expect this standard endpoint over
plain HTTP; wrapping it in gRPC would break interop for no benefit. See
`auth-service/README.md` for details.

**Exception — the edge:** `api-gateway` terminates public HTTP/REST traffic
from browsers/clients (which don't speak raw gRPC) and translates it to
gRPC calls against the internal services.

## Tooling

Uses [buf](https://buf.build/docs/installation) instead of raw `protoc`.

```bash
make lint       # lint all .proto files
make generate   # generate Go stubs into gen/go/
make breaking   # check for breaking changes vs main
```

## Versioning

Consumers `go get github.com/<you>/mini-iam-proto@vX.Y.Z` — pin to a tag,
never a branch, for the same reason `quangdd-github-workflows` is pinned by
tag (see that repo's README).

## Publishing this repo publicly

No secrets, no org-specific names, no internal infra details — safe to
make public as-is. `<your-org-or-user>` / `github.com/quangdd/...` in
`go_package` options and `go.mod` are placeholders — replace with your own
GitHub username before pushing.
