# Bump the given cask to the latest livecheck version
bump-version cask:
    #!/usr/bin/env bash
    set -euo pipefail

    # Linux runners can't evaluate some macOS-only cask DSL without simulation.
    if [ "$(uname -s)" = "Linux" ]; then
      export HOMEBREW_SIMULATE_MACOS_ON_LINUX=1
    fi

    tap_name="$(echo "${TAP_NAME:-local/tap}" | tr '[:upper:]' '[:lower:]')"
    full_cask_ref="${tap_name}/{{ cask }}"

    if [ ! -f "Casks/{{ cask }}.rb" ]; then
      echo "Cask not found: Casks/{{ cask }}.rb"
      exit 1
    fi

    brew tap "${tap_name}" "${PWD}" >/dev/null
    tap_repo="$(brew --repository "${tap_name}")"
    tap_cask_path="${tap_repo}/Casks/{{ cask }}.rb"

    # Keep Homebrew's tapped copy in sync with the working tree, then sync back after bump.
    cp "Casks/{{ cask }}.rb" "${tap_cask_path}"

    current_version="$(brew info --json=v2 --cask "${full_cask_ref}" | jq -r '.casks[0].version')"
    latest_version="$(brew livecheck --json --cask "${full_cask_ref}" | jq -r '.[0].version.latest // empty')"

    if [ -z "${latest_version}" ]; then
      echo "No livecheck version found for {{ cask }}."
      exit 1
    fi

    if [ "${latest_version}" = "${current_version}" ]; then
      echo "{{ cask }} is up to date (${current_version})."
      exit 0
    fi

    echo "Updating {{ cask }}: ${current_version} -> ${latest_version}"
    HOMEBREW_DEVELOPER=1 brew bump-cask-pr \
      --version "${latest_version}" \
      --write-only \
      --no-audit \
      --no-style \
      --no-browse \
      "${full_cask_ref}"

    cp "${tap_cask_path}" "Casks/{{ cask }}.rb"

# Bump every cask
bump-all:
    #!/usr/bin/env bash
    set -euo pipefail

    shopt -s nullglob
    cask_files=(Casks/*.rb)
    if [ "${#cask_files[@]}" -eq 0 ]; then
      echo "No casks found in Casks/."
      exit 0
    fi

    failures=()
    for file in "${cask_files[@]}"; do
      cask="$(basename "${file}" .rb)"
      if ! just bump-version "${cask}"; then
        failures+=("${cask}")
      fi
    done

    if [ "${#failures[@]}" -gt 0 ]; then
      echo
      echo "Failed to bump ${#failures[@]} cask(s): ${failures[*]}"
      exit 1
    fi
