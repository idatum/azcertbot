#!/bin/sh

test_multiple () {
    out=`echo "example.com,www.example.com,ssh.example.com" | awk -f ../domain_params.awk`
    if [ "${out}" != "-d example.com -d www.example.com -d ssh.example.com" ]
    then
        echo "test_multiple failed. ${out}"
        exit 2
    fi
}

test_single () {
    out=`echo "example.com" | awk -f ../domain_params.awk`
    if [ "${out}" != "-d example.com" ]
    then
        echo "test_single failed: ${out}"
        exit 2
    fi
}

test_multiple
test_single