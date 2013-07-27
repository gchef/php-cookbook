actions :create, :delete
default_action :create

attribute :name, :default => 'www'
# Unix user/group of processes
attribute :user, :default => 'www-data'
attribute :group, :default => 'www-data'

# The address on which to accept FastCGI requests.
# Valid syntaxes are:
#   'ip.add.re.ss:port'    - to listen on a TCP socket to a specific address on
#                            a specific port;
#   'port'                 - to listen on a TCP socket to all addresses on a
#                            specific port;
#   '/path/to/unix/socket' - to listen on a unix socket.
# Note: This value is mandatory.
attribute :listen, :default => '127.0.0.1:9000'

# Set listen(2) backlog. A value of '-1' means unlimited.
# Default Value: 128 (-1 on FreeBSD and OpenBSD)
attribute :listen_backlog, :default => '-1'

# Set permissions for unix socket, if one is used. In Linux, read/write
# permissions must be set in order to allow connections from a web server. Many
# BSD-derived systems allow connections regardless of permissions.
# Default Values: user and group are set as the running user mode is set to 0666
# listen.owner = www-data
# listen.group = www-data
# listen.mode = 0666
attribute :listen_owner, :default => 'root'
attribute :listen_group, :default => 'www-data'
attribute :listen_mode, :default => '0660'

# List of ipv4 addresses of FastCGI clients which are allowed to connect.
# Equivalent to the FCGI_WEB_SERVER_ADDRS environment variable in the original
# PHP FCGI (5.2.2+). Makes sense only with a tcp listening socket. Each address
# must be separated by a comma. If this value is left blank, connections will be
# accepted from any ip address.
# Default Value: any
attribute :listen_allowed_clients, :default => '127.0.0.1'

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
attribute :process_manager, :default => 'dynamic'

# The number of child processes to be created when pm is set to 'static' and the
# maximum number of child processes when pm is set to 'dynamic' or 'ondemand'.
# This value sets the limit on the number of simultaneous requests that will be
# served. Equivalent to the ApacheMaxClients directive with mpm_prefork.
# Equivalent to the PHP_FCGI_CHILDREN environment variable in the original PHP
# CGI. The below defaults are based on a server without much resources. Don't
# forget to tweak pm.* to fit your needs.
# Note: Used when pm is set to 'static', 'dynamic' or 'ondemand'
# Note: This value is mandatory.
attribute :max_children, :kind_of => Fixnum, :default => 2

# The number of child processes created on startup.
# Note: Used only when pm is set to 'dynamic'
# Default Value: min_spare_servers + (max_spare_servers - min_spare_servers) / 2
attribute :start_servers, :kind_of => Fixnum, :default => 1

# The desired minimum number of idle server processes.
# Note: Used only when pm is set to 'dynamic'
# Note: Mandatory when pm is set to 'dynamic'
attribute :min_spare_servers, :kind_of => Fixnum, :default => 1

# The desired maximum number of idle server processes.
# Note: Used only when pm is set to 'dynamic'
# Note: Mandatory when pm is set to 'dynamic'
attribute :max_spare_servers, :kind_of => Fixnum, :default => 1

# The number of seconds after which an idle process will be killed.
# Note: Used only when pm is set to 'ondemand'
attribute :process_idle_timeout, :default => '10s'

# The number of requests each child process should execute before respawning.
# This can be useful to work around memory leaks in 3rd party libraries. For
# endless request processing specify '0'. Equivalent to PHP_FCGI_MAX_REQUESTS.
attribute :max_requests, :kind_of => Fixnum, :default => 500

# The URI to view the FPM status page. If this value is not set, no URI will be
# recognized as a status page.
attribute :status_path

# The ping URI to call the monitoring page of FPM. If this value is not set, no
# URI will be recognized as a ping page. This could be used to test from outside
# that FPM is alive and responding, or to
attribute :ping_path

# This directive may be used to customize the response of a ping request. The
# response is formatted as text/plain with a 200 response code.
attribute :ping_response, :default => 'pong'

# The access log file
attribute :access_log, :default => "/var/log/php-fpm/$pool.access.log"

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
attribute :access_log_format, :default => '%R - %u %t " %m %r%Q%q " %s %f %{miliseconds}dms %{megabytes}MMB %C%%'

# The log file for slow requests
attribute :slow_log, :default => "/var/log/php-fpm/$pool.slow.log"

# The timeout for serving a single request after which a PHP backtrace will be
# dumped to the 'slowlog' file. A value of '0' means 'off'.
# Available units: s(econds)(default), m(inutes), h(ours), or d(ays)
attribute :request_slow_log_timeout, :default => '0s'
#
# The timeout for serving a single request after which the worker process will
# be killed. This option should be used when the 'max_execution_time' ini option
# does not stop script execution for some reason. A value of '0' means 'off'.
# Available units: s(econds)(default), m(inutes), h(ours), or d(ays)
attribute :request_terminate_timeout, :default => '0s'

# Environment variables hash
attribute :env, :kind_of => Hash, :default => {}
