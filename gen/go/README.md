# This directory is generated.

Run `make generate` (requires the `buf` CLI: https://buf.build/docs/installation)
to populate this folder with Go structs + gRPC client/server stubs from the
`.proto` files in `proto/`.

Nothing in here should be hand-edited. It is committed so that
`auth-service`, `user-service`, `rbac-service`, and `api-gateway` can `go get`
this module directly without every consumer needing the `buf` CLI installed.

After running `make generate`, commit the resulting `.pb.go` /
`_grpc.pb.go` files and tag a release (e.g. `v0.1.0`) for consumers to pin to.
