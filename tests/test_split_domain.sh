#!/bin/sh

test_zone_only () {
    out=`echo "example.com" | awk -f ../split_domain.awk`
    if [ "${out}" != "example.com" ]
    then
        echo "test_zone_only failed: ${out}"
        exit 2
    fi
}

test_multiple_subnames () {
    out=`echo "www.east.example.com" | awk -f ../split_domain.awk`
    if [ "${out}" != "www.east example.com" ]
    then
        echo "test_multiple_subnames failed: ${out}"
        exit 2
    fi
}

test_invalid_zone () {
    out=`echo "example" | awk -f ../split_domain.awk`
    if [ "${out}" != "Invalid domain: example" ]
    then
        echo "test_invalid_zone failed: ${out}"
        exit 2
    fi
}

test_zone_only
test_multiple_subnames
test_invalid_zone