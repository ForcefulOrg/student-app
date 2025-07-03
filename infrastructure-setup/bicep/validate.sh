#!/bin/bash

# Bicep Template Validation Script
# This script validates the Bicep templates for syntax and best practices

set -e

echo "🔍 Validating Bicep templates..."

# Check if Azure CLI and Bicep are installed
if ! command -v az &> /dev/null; then
    echo "❌ Azure CLI is not installed. Please install it first."
    exit 1
fi

if ! az bicep version &> /dev/null; then
    echo "📦 Installing Bicep..."
    az bicep install
fi

# Navigate to bicep directory
cd "$(dirname "$0")"

echo "📂 Working directory: $(pwd)"

# Validate main template
echo "✅ Validating main.bicep..."
az bicep build --file main.bicep --stdout > /dev/null

echo "✅ Validating individual modules..."

# Validate each module
for module in modules/*.bicep; do
    if [ -f "$module" ]; then
        echo "  📄 Validating $(basename "$module")..."
        az bicep build --file "$module" --stdout > /dev/null
    fi
done

# Check for parameter file
if [ -f "parameters.json" ]; then
    echo "✅ Parameters file found: parameters.json"
    # Validate JSON syntax
    if ! python3 -m json.tool parameters.json > /dev/null 2>&1; then
        echo "❌ Invalid JSON in parameters.json"
        exit 1
    fi
else
    echo "⚠️  No parameters.json file found"
fi

echo ""
echo "🎉 All Bicep templates are valid!"
echo ""
echo "📋 Template Summary:"
echo "  - Main template: main.bicep"
echo "  - Modules: $(ls modules/*.bicep | wc -l) files"
echo "  - Parameters: $([ -f parameters.json ] && echo "parameters.json" || echo "none")"
echo ""
echo "🚀 Ready for deployment!"