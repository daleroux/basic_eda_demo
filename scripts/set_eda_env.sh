#!/bin/bash

# Prompt user for Event Stream URL
read -p "Enter the Event Stream URL: " eda_url

# Prompt user for Token (silent input)
read -s -p "Enter the Token: " token
echo ""

# Export variables to current environment
export EDA_URL="$eda_url"
export TOKEN="$token"

# Print confirmation
echo "Environment variables set:"
echo "EDA_URL=$EDA_URL"
echo "TOKEN=********"

