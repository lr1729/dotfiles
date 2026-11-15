#!/usr/bin/env bash
set -euo pipefail

# The key is machine-local. Never store it in tracked dotfiles.
# Set OPENWEATHER_API_KEY or put the key in ~/.config/conky/.openweather-api-key.
api_key="${OPENWEATHER_API_KEY:-}"
key_file="${XDG_CONFIG_HOME:-$HOME/.config}/conky/.openweather-api-key"
if [[ -z "$api_key" && -r "$key_file" ]]; then
  IFS= read -r api_key < "$key_file" || [[ -n "$api_key" ]]
fi
if [[ -z "$api_key" ]]; then
  printf 'Missing OpenWeather API key: %s\n' "$key_file" >&2
  exit 1
fi
if [[ ! "$api_key" =~ ^[[:alnum:]]+$ ]]; then
  printf 'Invalid OpenWeather API key format\n' >&2
  exit 1
fi

city_id="${OPENWEATHER_CITY_ID:-5341704}"
cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}"
mkdir -p "$cache_dir"
tmp_file="$(mktemp "$cache_dir/weather.json.XXXXXX")"
trap 'rm -f "$tmp_file"' EXIT

# Only replace the offline cache after a successful download.
# Send the key on stdin, not in curl's process arguments.
printf 'data-urlencode = "appid=%s"\n' "$api_key" | \
  curl --config - --fail --silent --show-error --location \
    --connect-timeout 5 --max-time 15 \
    --get 'https://api.openweathermap.org/data/2.5/weather' \
    --data-urlencode "id=$city_id" \
    --data-urlencode 'units=imperial' --data-urlencode 'lang=en' \
    --output "$tmp_file"
jq -e '.weather[0].icon | type == "string"' "$tmp_file" >/dev/null
mv -f "$tmp_file" "$cache_dir/weather.json"
