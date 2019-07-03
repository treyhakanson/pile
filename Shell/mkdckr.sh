#!/bin/sh

while getopts ":d:" opt; do
	case $opt in
		d)
			docker-machine create --driver amazonec2 --amazonec2-instance-type t2.small  --amazonec2-ami ami-40d28157 $OPTARG
			;;
		:)
			echo "You must name the new docker-machine" >&2
			exit 1
			;;
	esac
done