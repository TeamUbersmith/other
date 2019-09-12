launch=gmysql

gmysql-dbname=ubersmith
gmysql-host=localhost
gmysql-port=3306
gmysql-user=ubersmith
gmysql-password=<password>

gmysql-basic-query=SELECT content,ttl,prio,type,zone_id,disabled,name,auth FROM dns_record WHERE disabled=0 and type=? and name=?
gmysql-id-query=SELECT content,ttl,prio,type,zone_id,disabled,name,auth FROM dns_record WHERE disabled=0 and type=? and name=? and zone_id=?
gmysql-any-query=SELECT content,ttl,prio,type,zone_id,disabled,name,auth FROM dns_record WHERE disabled=0 and name=?
gmysql-list-query=SELECT content,ttl,prio,type,zone_id,disabled,name,auth from dns_record where (disabled=0 OR ?) AND zone_id=?
gmysql-any-id-query=SELECT content,ttl,prio,type,zone_id,disabled,name,auth FROM dns_record WHERE disabled=0 and name=? and zone_id=?

gmysql-activate-domain-key-query=update dns_cryptokeys set active=1 where zone_id=(select zone_id from dns_zone where name=?) and  dns_cryptokeys.id=?
gmysql-add-domain-key-query=insert into dns_cryptokeys (zone_id, flags, active, content) select zone_id, ?, ?, ? from dns_zone where name=?
gmysql-clear-domain-all-keys-query=delete from dns_cryptokeys where zone_id=(select zone_id from dns_zone where name=?)
gmysql-clear-domain-all-metadata-query=delete from dns_domainmetadata where zone_id=(select zone_id from dns_zone where name=?)
gmysql-clear-domain-metadata-query=delete from dns_domainmetadata where zone_id=(select zone_id from dns_zone where name=?) and dns_domainmetadata.kind=?
gmysql-deactivate-domain-key-query=update dns_cryptokeys set active=0 where zone_id=(select zone_id from dns_zone where name=?) and  dns_cryptokeys.id=?

gmysql-delete-comment-rrset-query=DELETE FROM dns_comments WHERE zone_id=? AND name=? AND type=?
gmysql-delete-comments-query=DELETE FROM dns_comments WHERE zone_id=?
gmysql-delete-domain-query=delete from dns_zone where name=?
gmysql-delete-empty-non-terminal-query=delete from dns_record where zone_id=? and name=? and type is null
gmysql-delete-names-query=delete from dns_record where zone_id=? and name=?
gmysql-delete-rrset-query=delete from dns_record where zone_id=? and name=? and type=?
gmysql-delete-tsig-key-query=delete from dns_tsigkeys where name=?
gmysql-delete-zone-query=delete from dns_record where zone_id=?
gmysql-get-all-domain-metadata-query=select kind,content from dns_zone, dns_domainmetadata where dns_domainmetadata.zone_id=dns_zone.zone_id and name=?
gmysql-get-all-domains-query=select dns_zone.zone_id, dns_zone.name, dns_record.content, dns_zone.type, dns_zone.master, dns_zone.notified_serial, dns_zone.last_check, dns_zone.account from dns_zone LEFT JOIN dns_record ON dns_record.zone_id=dns_zone.zone_id AND dns_record.type='SOA' AND dns_record.name=dns_zone.name WHERE dns_record.disabled=0 OR ?
gmysql-get-domain-metadata-query=select content from dns_zone, dns_domainmetadata where dns_domainmetadata.zone_id=dns_zone.zone_id and name=? and dns_domainmetadata.kind=?
gmysql-get-order-after-query=select ordername from dns_record where ordername > ? and zone_id=? and disabled=0 and ordername is not null order by 1 asc limit 1
gmysql-get-order-before-query=select ordername, name from dns_record where ordername <= ? and zone_id=? and disabled=0 and ordername is not null order by 1 desc limit 1
gmysql-get-order-first-query=select ordername from dns_record where zone_id=? and disabled=0 and ordername is not null order by 1 asc limit 1
gmysql-get-order-last-query=select ordername, name from dns_record where ordername != '' and zone_id=? and disabled=0 and ordername is not null order by 1 desc limit 1
gmysql-get-tsig-key-query=select algorithm, secret from dns_tsigkeys where name=?
gmysql-get-tsig-keys-query=select name,algorithm, secret from dns_tsigkeys
gmysql-info-all-master-query=select zone_id,name,master,last_check,notified_serial,type from dns_zone where type='MASTER'
gmysql-info-all-slaves-query=select zone_id,name,master,last_check from dns_zone where type='SLAVE'
gmysql-info-zone-query=select zone_id,name,master,last_check,notified_serial,type,account from dns_zone where name=?
gmysql-insert-comment-query=INSERT INTO dns_comments (zone_id, name, type, modified_at, account, comment) VALUES (?, ?, ?, ?, ?, ?)
gmysql-insert-empty-non-terminal-order-query=insert into dns_record (type,zone_id,disabled,name,ordername,auth,change_date,content,ttl,prio) values (null,?,0,?,?,?,NULL,NULL,NULL,NULL)
gmysql-insert-record-query=insert into dns_record (content,ttl,prio,type,zone_id,disabled,name,ordername,auth,change_date) values (?,?,?,?,?,?,?,?,?,NULL)
gmysql-insert-zone-query=insert into dns_zone (type,name,master,account,last_check,notified_serial) values(?,?,?,?,NULL,NULL)
gmysql-list-domain-keys-query=select dns_cryptokeys.id, flags, active, content from dns_zone, dns_cryptokeys where dns_cryptokeys.zone_id=dns_zone.zone_id and name=?
gmysql-master-zone-query=select master from dns_zone where name=? and type='SLAVE'
gmysql-nullify-ordername-and-update-auth-query=update dns_record set ordername=NULL,auth=? where zone_id=? and name=? and disabled=0
gmysql-nullify-ordername-and-update-auth-type-query=update dns_record set ordername=NULL,auth=? where zone_id=? and name=? and type=? and disabled=0
gmysql-remove-domain-key-query=delete from dns_cryptokeys where zone_id=(select zone_id from dns_zone where name=?) and dns_cryptokeys.id=?
gmysql-remove-empty-non-terminals-from-zone-query=delete from dns_record where zone_id=? and type is null
gmysql-set-domain-metadata-query=insert into dns_domainmetadata (zone_id, kind, content) select zone_id, ?, ? from dns_zone where name=?
gmysql-supermaster-name-to-ips=select ip,account from dns_supermaster where nameserver=? and account=?
gmysql-supermaster-query=select account from dns_supermaster where ip=? and nameserver=?
gmysql-update-account-query=update dns_zone set account=? where name=?
gmysql-update-kind-query=update dns_zone set type=? where name=?
gmysql-update-lastcheck-query=update dns_zone set last_check=? where zone_id=?
gmysql-update-master-query=update dns_zone set master=? where name=?
gmysql-update-ordername-and-auth-query=update dns_record set ordername=?,auth=? where zone_id=? and name=? and disabled=0
gmysql-update-ordername-and-auth-type-query=update dns_record set ordername=?,auth=? where zone_id=? and name=? and type=? and disabled=0
gmysql-update-serial-query=update dns_zone set notified_serial=? where zone_id=?
gmysql-zone-lastchange-query=select max(change_date) from dns_record where zone_id=?

#################################
# local-address	Local IP address to which we bind
#
local-address=<IP ADDRESS OF DNS SERVER>

#################################
# local-port	The port on which we listen
#
local-port=53

#################################
# allow-recursion	List of netmasks that are allowed to recurse
#
#allow-recursion=127.0.0.1

#################################
# daemon	Operate as a daemon
#
# daemon=no

#################################
# guardian	Run within a guardian process
#
# guardian=no

#################################
# config-dir	Location of configuration directory (pdns.conf)
#
#config-dir=/etc/powerdns  # Debian Systems Path
config-dir=/etc/pdns

#################################
# disable-axfr	Disable zonetransfers but do allow TCP queries
#
disable-axfr=yes

#################################
# module-dir	Default directory for modules
#
# module-dir=/usr/lib/pdns  #Debian Systems Path


#################################
# setgid	If set, change group id to this gid for more security
#
setgid=pdns

#################################
# setuid	If set, change user id to this uid for more security
#
setuid=pdns

#################################
# socket-dir	Where the controlsocket will live
#
socket-dir=/var/run


# Autogenerated configuration file template
#################################
# allow-axfr-ips    If enabled, restrict zonetransfers to originate from these
#                   IP addresses
#
# allow-axfr-ips=


#################################
# allow-recursion-override   Local data even about hosts that don't exist will
#                            override the internet. (on/off)
#
# allow-recursion-override=

#################################
# cache-ttl	Seconds to store packets in the PacketCache
#
# cache-ttl=20

#################################
# chroot	If set, chroot to this directory for more security
#
# chroot=/var/spool/powerdns



#################################
# config-name	Name of this virtual configuration - will rename the binary image
#
# config-name=

#################################
# control-console	Debugging switch - don't use
#
# control-console=no


#################################
# default-soa-name	name to insert in the SOA record if none set in the backend
#
# default-soa-name=a.misconfigured.powerdns.server



#################################
# disable-tcp	Do not listen to TCP queries
#
# disable-tcp=no

#################################
# distributor-threads	Default number of Distributor (backend) threads to start
#
# distributor-threads=3

#################################
# fancy-records	Process URL and MBOXFW records
#
# fancy-records=no


#################################
# load-modules	Load this module - supply absolute or relative path
#
# load-modules=


#################################
# local-ipv6	Local IP address to which we bind
#
# local-ipv6=



#################################
# log-dns-details	If PDNS should log failed update requests
#
# log-dns-details=

#################################
# log-failed-updates	If PDNS should log failed update requests
#
# log-failed-updates=

#################################
# logfile	Logfile to use
#
# logfile=/var/log/pdns.log

#################################
# logging-facility	Log under a specific facility
#
# logging-facility=

#################################
# loglevel	Amount of logging. Higher is more. Do not set below 3
#
loglevel=9

#################################
# master	Act as a master
#
# master=no

#################################
# max-queue-length	Maximum queuelength before considering situation lost
#
# max-queue-length=5000

#################################
# max-tcp-connections	Maximum number of TCP connections
#
# max-tcp-connections=10



#################################
# negquery-cache-ttl	Seconds to store packets in the PacketCache
#
# negquery-cache-ttl=60

#################################
# out-of-zone-additional-processing	Do out of zone additional processing
#
# out-of-zone-additional-processing=no

#################################
# query-cache-ttl	Seconds to store packets in the PacketCache
#
# query-cache-ttl=20

#################################
# query-logging	Hint backends that queries should be logged
#
# query-logging=no

#################################
# queue-limit	Maximum number of milliseconds to queue a query
#
# queue-limit=1500

#################################
# query-local-address   The IP address to use as a source address for sending
#                       queries.
# query-local-address=

#################################
# receiver-threads	Number of receiver threads to launch
#
# receiver-threads=1

#################################
# recursive-cache-ttl	Seconds to store packets in the PacketCache
#
# recursive-cache-ttl=10

#################################
# recursor	If recursion is desired, IP address of a recursing nameserver
#
# recursor=



#################################
# skip-cname	Do not perform CNAME indirection for each query
#
# skip-cname=no

#################################
# slave	Act as a slave
#
# slave=no

#################################
# slave-cycle-interval	Reschedule failed SOA serial checks once every .. seconds
#
# slave-cycle-interval=60

#################################
# smtpredirector	Our smtpredir MX host
#
# smtpredirector=a.misconfigured.powerdns.smtp.server

#################################
# soa-minimum-ttl	Default SOA mininum ttl
#
# soa-minimum-ttl=3600

#################################
# soa-refresh-default  Default SOA refresh
#
# soa-refresh-default=10800

#################################
# soa-retry-default    Default SOA retry
#
# soa-retry-default=3600

#################################
# soa-expire-default   Default SOA expire
#
# soa-expire-default=604800

#################################
# soa-serial-offset	Make sure that no SOA serial is less than this number
#
# soa-serial-offset=0



#################################
# strict-rfc-axfrs	Perform strictly rfc compliant axfrs (very slow)
#
# strict-rfc-axfrs=no

#################################
# urlredirector	Where we send hosts to that need to be url redirected
#
# urlredirector=127.0.0.1

#################################
# use-logfile	Use a log file
#
# use-logfile=yes

#################################
# webserver	Start a webserver for monitoring
#
# webserver=no

#################################
# webserver-address	IP Address of webserver to listen on
#
# webserver-address=127.0.0.1

#################################
# webserver-password	Password required for accessing the webserver
#
# webserver-password=

#################################
# webserver-port	Port of webserver to listen on
#
# webserver-port=8081

#################################
# webserver-print-arguments	If the webserver should print arguments
#
# webserver-print-arguments=no

#################################
# wildcard-url	Process URL and MBOXFW records
#
# wildcard-url=no

#################################
# wildcards	Honor wildcards in the database
#
# wildcards=

#################################
# version-string   What should PowerDNS return for version
#                  allowed methods are anonymous / powerdns / full / custom
version-string=powerdns

#include-dir=/etc/pdns/pdns.d ## For CentOS based systems
#include-dir=/etc/powerdns/pdns.d ## For Debian based systems
