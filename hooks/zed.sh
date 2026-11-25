post_stow() {
    local zed_config_dir="$PKG_PATH/.config/zed"
    local shared_settings="$zed_config_dir/settings.shared.jsonc"
    local settings="$zed_config_dir/settings.json"
    local backup="$zed_config_dir/settings.backup.jsonc"
    local temporary="$zed_config_dir/.settings.json.tmp"

    if [[ "${DRY_RUN:-0}" == "1" ]]; then
        echo "⏭️  Skipping Zed settings merge during dry run"
        return 0
    fi

    if ! command -v ruby >/dev/null 2>&1; then
        err "Ruby is required to merge Zed's JSONC settings"
        return 1
    fi

    if [[ ! -f "$shared_settings" ]]; then
        err "Shared Zed settings not found: $shared_settings"
        return 1
    fi

    rm -f "$temporary"
    # Ruby provides dependency-free JSON parsing and deep merging on macOS while
    # allowing this hook to handle Zed's JSONC comments and trailing commas safely.
    if ! ruby -rjson - "$shared_settings" "$settings" "$temporary" <<'RUBY'
def strip_jsonc(input)
  output = +""
  in_string = false
  escaped = false
  line_comment = false
  block_comment = false
  index = 0

  while index < input.length
    char = input[index]
    following = input[index + 1]

    if line_comment
      if char == "\n"
        line_comment = false
        output << char
      end
    elsif block_comment
      if char == "*" && following == "/"
        block_comment = false
        index += 1
      elsif char == "\n"
        output << char
      end
    elsif in_string
      output << char
      if escaped
        escaped = false
      elsif char == "\\"
        escaped = true
      elsif char == '"'
        in_string = false
      end
    elsif char == '"'
      in_string = true
      output << char
    elsif char == "/" && following == "/"
      line_comment = true
      index += 1
    elsif char == "/" && following == "*"
      block_comment = true
      index += 1
    else
      output << char
    end

    index += 1
  end

  output.gsub(/,\s*([}\]])/, '\\1')
end

def parse_jsonc(path)
  JSON.parse(strip_jsonc(File.read(path)))
end

def leading_comments(input)
  prefix = input.match(%r!\A(?:(?:[ \t\r\n]+)|(?://[^\n]*(?:\n|\z))|(?:/\*.*?\*/))*!m)[0]
  return "" unless prefix.include?("//") || prefix.include?("/*")

  prefix.end_with?("\n") ? prefix : prefix + "\n"
end

def deep_merge(base, override)
  return override unless base.is_a?(Hash) && override.is_a?(Hash)

  base.merge(override) do |_key, base_value, override_value|
    deep_merge(base_value, override_value)
  end
end

shared_path, settings_path, output_path = ARGV
existing_source = File.exist?(settings_path) ? File.read(settings_path) : ""
existing = existing_source.empty? ? {} : JSON.parse(strip_jsonc(existing_source))
shared = parse_jsonc(shared_path)
comments = leading_comments(existing_source)

File.write(output_path, comments + JSON.pretty_generate(deep_merge(existing, shared)) + "\n")
RUBY
    then
        rm -f "$temporary"
        err "Failed to merge Zed settings"
        return 1
    fi

    local diff_source="$settings"
    [[ -f "$diff_source" ]] || diff_source="/dev/null"

    if cmp -s "$diff_source" "$temporary"; then
        rm -f "$temporary"
        log "Zed settings are already up to date"
        return 0
    fi

    if command -v git >/dev/null 2>&1; then
        local diff_status=0
        git --no-pager diff --no-index --color=always -- "$diff_source" "$temporary" || diff_status=$?
        if [[ "$diff_status" -gt 1 ]]; then
            rm -f "$temporary"
            err "Failed to display the Zed settings diff"
            return 1
        fi
    else
        diff -u "$diff_source" "$temporary" || true
    fi

    local confirmation
    if ! read -r -p "Apply this Zed settings merge? [y/N] " confirmation; then
        echo
        rm -f "$temporary"
        warn "Zed settings merge cancelled"
        return 0
    fi

    if [[ ! "$confirmation" =~ ^[Yy]$ ]]; then
        rm -f "$temporary"
        warn "Zed settings merge cancelled"
        return 0
    fi

    if [[ -f "$settings" ]]; then
        cp "$settings" "$backup"
    fi

    mv "$temporary" "$settings"
    log "Merged shared Zed settings into $settings"
}
