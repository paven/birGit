# Shared setup/teardown for birgit bats tests
# Source this in each test file via: load 'helpers'

BIRGIT_="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)/birgit_"

# Creates an isolated git repo in a temp dir and sets it as CWD.
# Commits one file on branch 'master' so HEAD is valid.
setup_repo() {
    TEST_REPO="$(mktemp -d)"
    cd "$TEST_REPO"
    git init -b master
    git config user.email "test@birgit"
    git config user.name "birgit test"
    git commit --allow-empty -m "initial"
}

teardown_repo() {
    rm -rf "$TEST_REPO"
}
