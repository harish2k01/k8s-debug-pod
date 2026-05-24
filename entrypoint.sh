#!/usr/bin/env bash
set -euo pipefail

cat <<'EOF'
Ubuntu debug container is ready.

Useful commands:
  kubectl get pods -A
  dig kubernetes.default.svc.cluster.local
  curl -vk https://kubernetes.default.svc
  ss -tulpn
EOF

exec sleep infinity
