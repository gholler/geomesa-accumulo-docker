#! /usr/bin/env bash

#set -x
set -u



ping_accumulo()
{
    user=$1
    password=$2

    accumulo shell -u $user -p pass:$password -e "tables" #> /dev/null
}

fail()
{
    echo $1
    exit 1
}


start_accumulo()
{
    /start-accumulo &
}

stop_accumulo()
{
    # anything on shutdown port will stop the cluster
    # nc localhost 41414


    /usr/local/accumulo/bin/stop-all.sh
}


wait_until_accumulo_available()
{
    MAX_TRIES=5
    tries=0
    available=false

    while [[ $tries -lt $MAX_TRIES ]]
    do
        ping_accumulo $@
        if [[ $? -eq 0 ]]
        then
		available=true
                break
        fi
        sleep 10
        tries=$((tries+1))
    done

    [ "$available" == "true" ] || fail "accumulo unavailable after $MAX_TRIES tries - aborting"
}


