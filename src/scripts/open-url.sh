open-url() {
    local url="$1"

    if [ -z "${1:-}" ]; then
        echo "open-url: url must be supplied"
        return 1
    fi

    for cmd in open gnome-open kde-open xdg-open sensible-browser; do
        if type "$cmd" 1>/dev/null 2>&1; then
            echo "opening $url via $cmd..."
            "$cmd" "$url"
            return 0
        fi
    done

    return 1
}