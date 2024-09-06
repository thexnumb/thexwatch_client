#!/bin/bash
programs() {
    local all="false"
    local delete="false"

    # Parse the options
    while [[ "$#" -gt 0 ]]; do
        case $1 in
            --delete) delete="true"; shift ;;
            --all) all="true" ;;
            *) echo "Unknown parameter passed: $1"; exit 1 ;;
        esac
        shift
    done

    if [[ "$all" == "false" && "$delete" == "false" ]]; then
        echo "Error: You must specify --all for get all programs or --delete for delete specific program."
        exit 1
    fi

    # Construct the URL
    local url="127.0.0.1:5000/api/programs"
    [[ "$all" == "true" ]] && url+="/all"

    # Remove trailing '&'
    url=${url%&}

    # Make the curl request
    curl -s "$url"
}
# Function to make the API request

subdomains() {
    # Initialize variables
    local program=""
    local scope=""
    local provider=""
    local fresh="false"
    local count="false"
    local limit="1000"
    local page="1"
    local json="false"
    local all="false"
    local single="false"
    local subdomain=""

    # Parse the options
    while [[ "$#" -gt 0 ]]; do
        case $1 in
            --program) program="$2"; shift ;;
            --scope) scope="$2"; shift ;;
            --provider) provider="$2"; shift ;;
            --fresh) fresh="true"; ;;
            --count) count="true"; ;;
            --limit) limit="$2"; shift ;;
            --page) page="$2"; shift ;;
            --json) json="true"; ;;
            --all) all="true"; ;;
            --subdomain) subdomain="$2"; shift ;;
            --single) single="true" ;;
            *) echo "Unknown parameter passed: $1"; exit 1 ;;
        esac
        shift
    done

    # Validate input
    if [[ "$single" == "false" && "$all" == "false" && -z "$program" && -z "$scope" && -z "$provider" ]]; then
        echo "Error: You must specify at least one of --program, --scope, or --provider, or use --all."
        exit 1
    fi

    # Construct the base URL
    local url="127.0.0.1:5000/api/subdomains"

    # Append the subdomain details if --single and --subdomain are specified
    if [[ "$single" == "true" && -n "$subdomain" ]]; then
        url+="/details/${subdomain}"
    else
        # Start building the query string
        local query=""

        # Append options to the query string
        [[ "$all" == "true" ]] && query+="all=true&"
        [[ -n "$program" ]] && query+="program=${program}&"
        [[ -n "$scope" ]] && query+="scope=${scope}&"
        [[ -n "$provider" ]] && query+="provider=${provider}&"
        [[ "$fresh" == "true" ]] && query+="fresh=true&"
        [[ "$count" == "true" ]] && query+="count=true&"
        [[ -n "$limit" ]] && query+="limit=${limit}&"
        [[ -n "$page" ]] && query+="page=${page}&"
        [[ "$json" == "true" ]] && query+="json=true&"

        # Remove the trailing '&' if any and append to the URL
        if [[ -n "$query" ]]; then
            url+="?${query%&}"
        fi
    fi

    # Make the curl request
    curl -s "$url"
}

lives() {
    # Initialize variables
    local program=""
    local scope=""
    local provider=""
    local tag=""
    local fresh="false"
    local count="false"
    local limit="1000"
    local page="1"
    local json="false"
    local all="false"
    local single="false"
    local subdomain=""

    # Parse the options
    while [[ "$#" -gt 0 ]]; do
        case $1 in
            --program) program="$2"; shift ;;
            --scope) scope="$2"; shift ;;
            --provider) provider="$2"; shift ;;
            --tag) tag="$2"; shift ;;
            --fresh) fresh="true"; ;;
            --count) count="true"; ;;
            --limit) limit="$2"; shift ;;
            --page) page="$2"; shift ;;
            --json) json="true"; ;;
            --all) all="true"; ;;
            --subdomain) subdomain="$2"; shift ;;
            --single) single="true" ;;
            *) echo "Unknown parameter passed: $1"; exit 1 ;;
        esac
        shift
    done

    # Validate input: at least one of --program, --scope, --provider, or --all should be provided, unless --single is used
    if [[ "$single" == "false" && "$all" == "false" && -z "$program" && -z "$scope" && -z "$provider" ]]; then
        echo "Error: You must specify at least one of --program, --scope, or --provider, or use --all."
        exit 1
    fi

    # Construct the base URL
    local url="127.0.0.1:5000/api/subdomains/live"

    # Check if --single and --subdomain are specified, if so, construct the URL for subdomain details
    if [[ "$single" == "true" && -n "$subdomain" ]]; then
        url+="/details/${subdomain}"
    else
        # Start building the query string
        local query=""

        # Append options to the query string
        [[ "$all" == "true" ]] && query+="all=true&"
        [[ -n "$program" ]] && query+="program=${program}&"
        [[ -n "$scope" ]] && query+="scope=${scope}&"
        [[ -n "$provider" ]] && query+="provider=${provider}&"
        [[ -n "$tag" ]] && query+="tag=${tag}&"
        [[ "$fresh" == "true" ]] && query+="fresh=true&"
        [[ "$count" == "true" ]] && query+="count=true&"
        [[ -n "$limit" ]] && query+="limit=${limit}&"
        [[ -n "$page" ]] && query+="page=${page}&"
        [[ "$json" == "true" ]] && query+="json=true&"

        # Remove the trailing '&' if any and append to the URL
        if [[ -n "$query" ]]; then
            url+="?${query%&}"
        fi
    fi

    # Make the curl request
    curl -s "$url"
}

https() {
    # Initialize variables
    local program=""
    local scope=""
    local provider=""
    local title=""
    local tech=""
    local status=""
    local fresh="false"
    local latest="false"
    local count="false"
    local limit="1000"
    local page="1"
    local json="false"
    local all="false"
    local single="false"
    local subdomain=""

    # Parse the options
    while [[ "$#" -gt 0 ]]; do
        case $1 in
            --program) program="$2"; shift ;;
            --scope) scope="$2"; shift ;;
            --provider) provider="$2"; shift ;;
            --title) title="$2"; shift ;;
            --tech) tech="$2"; shift ;;
            --status) status="$2"; shift ;;   # Fix: Added shift here
            --fresh) fresh="true" ;;
            --latest) latest="true" ;;
            --count) count="true" ;;
            --limit) limit="$2"; shift ;;
            --page) page="$2"; shift ;;
            --json) json="true" ;;
            --all) all="true" ;;
            --subdomain) subdomain="$2"; shift ;;
            --single) single="true" ;;
            *) echo "Unknown parameter passed: $1"; exit 1 ;;
        esac
        shift
    done

    # Validate input: at least one of --program, --scope, --provider, or --all should be provided, unless --single is used
    if [[ "$single" == "false" && "$all" == "false" && -z "$program" && -z "$scope" && -z "$provider" ]]; then
        echo "Error: You must specify at least one of --program, --scope, or --provider, or use --all."
        exit 1
    fi

    # Construct the base URL
    local url="127.0.0.1:5000/api/subdomains/http"

    # Check if --single and --subdomain are specified, if so, construct the URL for subdomain details
    if [[ "$single" == "true" && -n "$subdomain" ]]; then
        url+="/details/${subdomain}"
    else
        # Start building the query string
        local query=""

        # Append options to the query string
        [[ "$all" == "true" ]] && query+="all=true&"
        [[ -n "$program" ]] && query+="program=${program}&"
        [[ -n "$scope" ]] && query+="scope=${scope}&"
        [[ -n "$provider" ]] && query+="provider=${provider}&"
        [[ -n "$title" ]] && query+="title=${title}&"
        [[ -n "$tech" ]] && query+="tech=${tech}&"
        [[ -n "$status" ]] && query+="status=${status}&"  # Fix: Status is now properly appended
        [[ "$fresh" == "true" ]] && query+="fresh=true&"
        [[ "$latest" == "true" ]] && query+="latest=true&"
        [[ "$count" == "true" ]] && query+="count=true&"
        [[ -n "$limit" ]] && query+="limit=${limit}&"
        [[ -n "$page" ]] && query+="page=${page}&"
        [[ "$json" == "true" ]] && query+="json=true&"

        # Remove the trailing '&' if any and append to the URL
        if [[ -n "$query" ]]; then
            url+="?${query%&}"
        fi
    fi

    # Make the curl request
    curl -s "$url"
}

show_banner() {
    echo "$(figlet -f slant 'TheXWatch')v1.0"
    echo "Created by @thexnumb"
    echo ""
}

show_help() {
    cat << EOF
Usage: $0 [func] [switch] {input} (if needed)

Available functions:
    programs                     - get programs
                                    --all                        - get all programs.
                                    --delete                     - delete one specific program.
    subdomains                   - get subdomains
                                    --program <name>             - Specify the program name.
                                    --scope <domain>             - Specify the domain.
                                    --provider <provider>        - Specify the provider name.
                                    --fresh                      - get only fresh subdomains.
                                    --count                      - get only the count of subdomains.
                                    --limit <number>             - (Optional) Limit the number of subdomains returned (default is 1000).
                                    --page <number>              - (Optional) Specify the page number for paginated results (default is 1).
                                    --json                       - receive output in JSON format.
                                    --single                     - get details about one specific subdomain
                                        ---subdomain <subdomain>
    lives                        - get lives
                                    --program <name>             - Specify the program name.
                                    --scope <domain>             - Specify the domain.
                                    --provider <provider>        - Specify the provider name.
                                    --tag <string>               - for now just "cdn", "public", "private"
                                    --fresh                      - get only fresh subdomains.
                                    --count                      - get only the count of subdomains.
                                    --limit <number>             - (Optional) Limit the number of subdomains returned (default is 1000).
                                    --page <number>              - (Optional) Specify the page number for paginated results (default is 1).
                                    --json                       - receive output in JSON format.
                                    --single                     - get details about one specific subdomain
                                        ---subdomain <subdomain>
    https                        - get http 
                                    --program <name>             - Specify the program name.
                                    --scope <domain>             - Specify the domain.
                                    --provider <provider>        - Specify the provider name.
                                    --title <string>             - specify the title you want
                                    --status <string>             - specify the title you want
                                    --fresh                      - get only fresh subdomains.
                                    --count                      - get only the count of subdomains.
                                    --limit <number>             - (Optional) Limit the number of subdomains returned (default is 1000).
                                    --page <number>              - (Optional) Specify the page number for paginated results (default is 1).
                                    --json                       - receive output in JSON format.
                                    --single                     - get details about one specific subdomain
                                        ---subdomain <subdomain>

EOF
}



# Check for help option or call the function
if [[ $# -lt 1 ]]; then
    show_banner
    show_help
    exit 1
fi

case $1 in
    programs)
        programs "${@:2}"
        ;;
    subdomains)
        subdomains "${@:2}"
        ;;
    lives)
        lives "${@:2}"
        ;;
    https)
        https "${@:2}"
        ;;
    -h|--help|help)
        show_help
        ;;
    *)
        echo "Function '$1' not recognized."
        show_help
        ;;
esac
