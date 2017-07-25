#!/usr/bin/expect

set timeout -1

spawn php /tmp/go-pear.phar

expect "1-12, 'all' or Enter to continue:"
send "\r"
expect eof

spawn rm /tmp/go-pear.phar
