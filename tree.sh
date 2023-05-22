#!/bin/bash

#Function for checking arguments of height
function check_height() {
    local height="$1"
    if [ -z "$height" ]; then
        echo "The height of the the tree is not found"
        exit 1
    fi

    if ! [ "$height" -eq "$height" ] 2> /dev/null; then
        echo "The value of height must be integer!"
        exit 1
    fi

    if [ "$height" -lt 1 ]; then
        echo "The height of tree cannot be less than 1"
        exit 1
    fi
}

#Function for printing help
function print_help() {
    echo "Usage: bash tree.sh <height>"
}

#Function for printing version
function print_version() {
    echo "Tree v1.0.0"
}

#Function for checking options for versions or help
function check_options() {
    case "$1" in
        -h | --help)
            print_help
            exit 0
            ;;
        -v | --version)
            print_version
            exit 0
            ;;
    esac
}

#Print snowflake on the screen
function print_snowflake() {
    if [ $((RANDOM % 6 )) -eq 0 ]; then
        echo -n "."
    else
        echo -n " "
    fi
}

#Print snow on the screen
function print_snow() {
    local count=$1
    for i in $(seq 0 $(( count - 1 )) ); do
        print_snowflake
    done
}

#Main function
function main() {
    local height="$1"

    check_height "$height"

    for row in $(seq 0 $(( height )) ); do
        print_snow $(( height - row - 1))
        for column in $(seq 0 $(( row - 1 )) ); do
            FG=$(( RANDOM % 40 ))
            BG=$(( RANDOM % 40 ))
            echo -e -n "\033[${FG};${BG}m* \033[0m"
        done
        print_snow $(( height - row  - 1 ))
        echo ""
    done

    for row in $(seq 0 $(( height / 2 - 1 )) ); do
        print_snow $(( height - 2 ))
        echo -n "#"
        print_snow $(( height - 2 ))
        echo ""
    done
}

#Start of script
check_options $1
main $*
