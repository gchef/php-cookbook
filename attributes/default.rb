default[:php][:version]             = '5.3.10'
default[:php][:core_packages]       = %w[php5 php5-common php5-cli php5-dev php-pear]

default[:php][:extensions_dir]  = '/usr/lib/php5/ext'
default[:php][:conf_dir]        = '/etc/php5'
default[:php][:ext_conf_dir]    = '/etc/php5/conf.d'

default[:php][:extensions]      = []



########################################################################### PHP-FPM #
#
# Pid file
# Note: the default prefix is /var
default[:php][:fpm][:pid] = '/var/run/php5-fpm.pid'
#
# Error log file
# If it's set to "syslog", log is sent to syslogd instead of being written
# in a local file.
# Note: the default prefix is /var
set[:php][:fpm][:log_dir] = '/var/log/php-fpm'
default[:php][:fpm][:error_log] = "#{php[:fpm][:log_dir]}/error.log"
#
# syslog_facility is used to specify what type of program is logging the
# message. This lets syslogd specify that messages from different facilities
# will be handled differently.
# See syslog(3) for possible values (ex daemon equiv LOG_DAEMON)
default[:php][:fpm][:syslog_facility] = 'daemon'
#
# syslog_ident is prepended to every message. If you have multiple FPM
# instances running on the same server, you can change the default value
# which must suit common needs.
default[:php][:fpm][:syslog_ident] = 'php-fpm'
#
# Log level
# Possible Values: alert, error, warning, notice, debug
default[:php][:fpm][:log_level] = 'notice'
#
# The maximum number of processes FPM will fork. This has been design to control
# the global number of processes when using dynamic PM within a lot of pools.
# Use it with caution.
# Note: A value of 0 indicates no limit
default[:php][:fpm][:process_max] = 128



####################################################################### PHP-FPM-WWW #
#
# Start a new pool.
# the variable $pool can we used in any directive and will be replaced by the
# pool name ('www' here)
default[:php][:fpm][:www][:pool_name] = 'www'
#
# Unix user/group of processes
default[:php][:fpm][:www][:user] = 'www-data'
default[:php][:fpm][:www][:group] = 'www-data'
#
# The address on which to accept FastCGI requests.
# Valid syntaxes are:
#   'ip.add.re.ss:port'    - to listen on a TCP socket to a specific address on
#                            a specific port;
#   'port'                 - to listen on a TCP socket to all addresses on a
#                            specific port;
#   '/path/to/unix/socket' - to listen on a unix socket.
# Note: This value is mandatory.
default[:php][:fpm][:www][:listen] = '127.0.0.1:9000'
#
# Choose how the process manager will control the number of child processes.
# Possible Values:
#   static  - a fixed number (pm.max_children) of child processes;
#   dynamic - the number of child processes are set dynamically based on the
#             following directives. With this process management, there will be
#             always at least 1 children.
#             pm.max_children      - the maximum number of children that can
#                                    be alive at the same time.
#             pm.start_servers     - the number of children created on startup.
#             pm.min_spare_servers - the minimum number of children in 'idle'
#                                    state (waiting to process). If the number
#                                    of 'idle' processes is less than this
#                                    number then some children will be created.
#             pm.max_spare_servers - the maximum number of children in 'idle'
#                                    state (waiting to process). If the number
#                                    of 'idle' processes is greater than this
#                                    number then some children will be killed.
#  ondemand - no children are created at startup. Children will be forked when
#             new requests will connect. The following parameter are used:
#             pm.max_children           - the maximum number of children that
#                                         can be alive at the same time.
#             pm.process_idle_timeout   - The number of seconds after which
#                                         an idle process will be killed.
# Note: This value is mandatory.
default[:php][:fpm][:www][:pm] = 'dynamic'
#
# The number of child processes to be created when pm is set to 'static' and the
# maximum number of child processes when pm is set to 'dynamic' or 'ondemand'.
# This value sets the limit on the number of simultaneous requests that will be
# served. Equivalent to the ApacheMaxClients directive with mpm_prefork.
# Equivalent to the PHP_FCGI_CHILDREN environment variable in the original PHP
# CGI. The below defaults are based on a server without much resources. Don't
# forget to tweak pm.* to fit your needs.
# Note: Used when pm is set to 'static', 'dynamic' or 'ondemand'
# Note: This value is mandatory.
default[:php][:fpm][:www][:max_children] = 10
#
# The number of child processes created on startup.
# Note: Used only when pm is set to 'dynamic'
# Default Value: min_spare_servers + (max_spare_servers - min_spare_servers) / 2
default[:php][:fpm][:www][:start_servers] = 4
#
# The desired minimum number of idle server processes.
# Note: Used only when pm is set to 'dynamic'
# Note: Mandatory when pm is set to 'dynamic'
default[:php][:fpm][:www][:min_spare_servers] = 2
#
# The desired maximum number of idle server processes.
# Note: Used only when pm is set to 'dynamic'
# Note: Mandatory when pm is set to 'dynamic'
default[:php][:fpm][:www][:max_spare_servers] = 6
#
# The number of seconds after which an idle process will be killed.
# Note: Used only when pm is set to 'ondemand'
default[:php][:fpm][:www][:process_idle_timeout] = '10s'
#
# The number of requests each child process should execute before respawning.
# This can be useful to work around memory leaks in 3rd party libraries. For
# endless request processing specify '0'. Equivalent to PHP_FCGI_MAX_REQUESTS.
default[:php][:fpm][:www][:max_requests] = 500
#
# The URI to view the FPM status page. If this value is not set, no URI will be
# recognized as a status page.
default[:php][:fpm][:www][:status_path] = false
#
# The ping URI to call the monitoring page of FPM. If this value is not set, no
# URI will be recognized as a ping page. This could be used to test from outside
# that FPM is alive and responding, or to
default[:php][:fpm][:www][:ping_path] = false
#
# This directive may be used to customize the response of a ping request. The
# response is formatted as text/plain with a 200 response code.
default[:php][:fpm][:www][:ping_response] = 'pong'
#
# The access log file
default[:php][:fpm][:www][:access_log] = "#{php[:fpm][:log_dir]}/$pool.access.log"
#
# The access log format.
# The following syntax is allowed
#  %%: the '%' character
#  %C: %CPU used by the request
#      it can accept the following format:
#      - %{user}C for user CPU only
#      - %{system}C for system CPU only
#      - %{total}C  for user + system CPU (default)
#  %d: time taken to serve the request
#      it can accept the following format:
#      - %{seconds}d (default)
#      - %{miliseconds}d
#      - %{mili}d
#      - %{microseconds}d
#      - %{micro}d
#  %e: an environment variable (same as $_ENV or $_SERVER)
#      it must be associated with embraces to specify the name of the env
#      variable. Some exemples:
#      - server specifics like: %{REQUEST_METHOD}e or %{SERVER_PROTOCOL}e
#      - HTTP headers like: %{HTTP_HOST}e or %{HTTP_USER_AGENT}e
#  %f: script filename
#  %l: content-length of the request (for POST request only)
#  %m: request method
#  %M: peak of memory allocated by PHP
#      it can accept the following format:
#      - %{bytes}M (default)
#      - %{kilobytes}M
#      - %{kilo}M
#      - %{megabytes}M
#      - %{mega}M
#  %n: pool name
#  %o: ouput header
#      it must be associated with embraces to specify the name of the header:
#      - %{Content-Type}o
#      - %{X-Powered-By}o
#      - %{Transfert-Encoding}o
#      - ....
#  %p: PID of the child that serviced the request
#  %P: PID of the parent of the child that serviced the request
#  %q: the query string 
#  %Q: the '?' character if query string exists
#  %r: the request URI (without the query string, see %q and %Q)
#  %R: remote IP address
#  %s: status (response code)
#  %t: server time the request was received
#      it can accept a strftime(3) format:
#      %d/%b/%Y:%H:%M:%S %z (default)
#  %T: time the log has been written (the request has finished)
#      it can accept a strftime(3) format:
#      %d/%b/%Y:%H:%M:%S %z (default)
#  %u: remote user
default[:php][:fpm][:www][:access_format] = '%R - %u %t "%m %r%Q%q" %s %f %{mili}d %{kilo}M %C%%'
#
# The log file for slow requests
default[:php][:fpm][:www][:slow_log] = "#{php[:fpm][:log_dir]}/$pool.slow.log"
#
# The timeout for serving a single request after which a PHP backtrace will be
# dumped to the 'slowlog' file. A value of '0' means 'off'.
# Available units: s(econds)(default), m(inutes), h(ours), or d(ays)
default[:php][:fpm][:www][:request_slow] = 0
#
# The timeout for serving a single request after which the worker process will
# be killed. This option should be used when the 'max_execution_time' ini option
# does not stop script execution for some reason. A value of '0' means 'off'.
# Available units: s(econds)(default), m(inutes), h(ours), or d(ays)
default[:php][:fpm][:www][:request_terminate] = 0

default[:php][:suhosin][:session_cryptdocroot] = 'On'
default[:php][:suhosin][:memory_limit] = '64M'
