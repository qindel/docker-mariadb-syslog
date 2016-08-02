#!/bin/sh
mkdir -p /etc/rsyslog
cat /dev/null > /etc/rsyslog/00-remote.conf
[ -n "$UDPLOGHOST" ] && echo "*.* @$UDPLOGHOST" >> /etc/rsyslog/00-remote.conf
[ -n "$TCPLOGHOST" ] && echo "*.* @@$TCPLOGHOST" >> /etc/rsyslog/00-remote.conf
[ -n "$UDPLOGHOST" -o -n "$TCPLOGHOST" ] && /usr/sbin/rsyslogd -f /etc/rsyslog.conf
mkdir /var/run/mysqld
chown mysql:mysql /var/run/mysqld
if [ -n "$UDPLOGHOST" -o -n "$TCPLOGHOST" ]; then
    echo running mysqld_safe
    exec /usr/bin/mysqld_safe --syslog
    # Exec effectively stops the script
else
    exec /usr/bin/mysqld
fi
