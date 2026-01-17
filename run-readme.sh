#!/usr/bin/env bash
set -e

# Run README.md - Validate README documentation
# This script validates that the README.md file exists and is well-formed

echo "Running README.md validation..."

# Check if README.md exists
if [ ! -f "README.md" ]; then
    echo "Error: README.md not found" >&2
    exit 1
fi

echo "✓ README.md exists"

# Check if README.md is not empty
if [ ! -s "README.md" ]; then
    echo "Error: README.md is empty" >&2
    exit 1
fi

echo "✓ README.md is not empty"

# Check for required sections
required_sections=(
    "Introduction and Overview"
    "Getting Started"
    "Installation"
    "Launching the CLI"
)

missing_sections=()
for section in "${required_sections[@]}"; do
    if ! grep -q "^#.*$section" README.md; then
        echo "✗ Section '$section' not found in README.md" >&2
        missing_sections+=("$section")
    else
        echo "✓ Section '$section' found"
    fi
done

if [ ${#missing_sections[@]} -gt 0 ]; then
    echo ""
    echo "Error: Required sections missing from README.md" >&2
    exit 1
fi

echo ""
echo "README.md validation complete!"
