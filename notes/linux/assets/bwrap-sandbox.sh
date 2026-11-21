#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -eq 0 ]; then
  echo "Usage: ./run-agent.sh <command>" >&2
  exit 2
fi

WORKDIR="$(realpath "${WORKDIR:-$PWD}")"
[ -d "$WORKDIR" ] || { echo "WORKDIR does not exist: $WORKDIR" >&2; exit 1; }

uid="$(id -u)"
gid="$(id -g)"

args=(
  # Isolation and Lifecycle
  --unshare-all
  --share-net
  --die-with-parent
  --new-session
  --clearenv

  # Base read-only file system
  --ro-bind /usr /usr
  --symlink usr/lib /lib
  --symlink usr/lib64 /lib64
  --symlink usr/bin /bin
  --symlink usr/sbin /sbin

  # Pseudo-filesystems and temporary directories
  --proc /proc
  --dev /dev
  --tmpfs /tmp
  --tmpfs /var/tmp

  # Read-only pass-through for DNS/certs
  --ro-bind-try /etc/resolv.conf /etc/resolv.conf
  --ro-bind-try /etc/ssl /etc/ssl
  --ro-bind-try /etc/ca-certificates /etc/ca-certificates
  --ro-bind-try /etc/pki /etc/pki

  # Workspace
  --bind "$WORKDIR" /workspace
  --chdir /workspace

  # Runtime environment
  --setenv PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
  --dir /run/user/$uid
  --setenv XDG_RUNTIME_DIR "/run/user/$uid"
  --setenv LANG C.UTF-8
  --setenv TERM dumb

  # User/Group Information
  --file 11 /etc/passwd
  --file 12 /etc/group

  # Forwarding parameters
  # --
  "$@"
)

exec bwrap "${args[@]}" \
  11< <(getent passwd "$uid") \
  12< <(getent group "$gid")
