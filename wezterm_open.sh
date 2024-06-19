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

get_pwd() {
  # Get the current working directory
  current_dir=$(pwd)

  # Get the length of the current directory string
  dir_length=${#current_dir}

  # Check if the length of the directory is less than or equal to 13
  if [ "$dir_length" -le 13 ]; then
      # If the directory length is less than or equal to 13, print the whole directory
      echo "$current_dir"
  else
      # Otherwise, extract and print the last 13 characters
      echo "..${current_dir: -13}"
  fi
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
wezterm cli set-tab-title "$(get_pwd)"
