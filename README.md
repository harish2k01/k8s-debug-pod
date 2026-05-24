# k8s-debug-pod

Ubuntu-based Kubernetes troubleshooting image used by the `k8s-debug-pod` Helm chart in the `harish2k01/helm-charts` repository.

## Image

```text
ghcr.io/harish2k01/k8s-debug-pod
```

## Build Locally

```bash
docker build -t k8s-debug-pod:local .
```

## Release Flow

Every PR merged into `master` creates a GitHub Release automatically.

The release workflow reads the commits included since the latest stable semver tag and chooses the next version from Conventional Commit messages:

- `BREAKING CHANGE:` in the commit body or a breaking subject like `feat!:` increments the major version.
- `feat:` increments the minor version.
- `fix:`, `perf:`, `revert:`, docs, CI, build, chore, refactor, test, style, and any other merged change increments the patch version.

For example, if the latest release is `v1.2.3`, a merged PR containing `feat: add kubectl plugins` creates `v1.3.0`. A merged PR containing `fix: update dns tools` creates `v1.2.4`.

If no previous release tag exists, the first non-breaking release starts at `v0.1.0`.

The workflow writes release notes from the included commit messages, creates the GitHub Release, then builds and pushes the multi-arch image. Stable releases publish these GHCR tags:

- `1.2.3`
- `1.2`
- `1`
- `latest`

The automatic release workflow creates stable releases only. Pull requests build the image for validation but do not push it. Release builds publish `linux/amd64` and `linux/arm64` images to GHCR.

When publishing a new image:

1. Merge a PR into `master`.
2. The release workflow calculates the next semver tag and creates a release with generated notes.
3. The workflow validates the release tag, builds a multi-arch image, logs in to GHCR, and pushes the generated tags.


## Included Tools

- Shell and file basics: `bash`, `less`, `nano`, `vim-tiny`
- HTTP and TLS: `curl`, `wget`, `openssl`, `ca-certificates`
- DNS: `dig`, `nslookup`, `host`
- Network debugging: `ip`, `ping`, `tracepath`, `traceroute`, `mtr`, `ss`, `netstat`, `nc`, `socat`, `nmap`, `tcpdump`
- Process debugging: `ps`, `top`, `lsof`, `strace`
- Data helpers and scripting: `jq`, `yq`, `python3`, `pip`, `venv`
- Cluster access: `kubectl`
- Common clients: `psql`, `mysql`, `redis-cli`, `telnet`
