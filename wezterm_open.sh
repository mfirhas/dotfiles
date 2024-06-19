# This script will set wezterm tab title and execute $1 with arg $2

binary="$1"
filepath="$2"

back_to_br="br"

# get last part of space separated string
get_last_space_separated() {
    local input_string="$1"
    local last_part=$(echo "$input_string" | awk '{print $NF}')
    echo "$last_part"
}

# get last part of slash separated string
get_last_slash_separated() {
    local input_path="$1"
    local last_part=$(echo "$input_path" | awk -F'/' '{print $NF}')
    echo "$last_part"
}

get_tab_title() {
  if [[ $filepath == *" "* ]]; then
    local last_space_separated=$(get_last_space_separated "$filepath")
    local base_space_separated=$(get_last_slash_separated "$last_space_separated")
    echo "$binary - $base_space_separated"
  else
    local base=$(get_last_slash_separated "$filepath")
    echo "$binary - $base"
  fi
}

wezterm cli set-tab-title "$(get_tab_title)"
$binary $filepath
wezterm cli set-tab-title "$back_to_br"
