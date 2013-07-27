default[:php][:version]        = '5.3.10'
default[:php][:core_packages]  = %w[php5-common php5-cli php5-dev php-pear]

default[:php][:extensions_dir] = '/usr/lib/php5/ext'
default[:php][:conf_dir]       = '/etc/php5'
default[:php][:ext_conf_dir]   = '/etc/php5/conf.d'

default[:php][:extensions]     = []



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
default[:php][:fpm][:error_log] = "/var/log/php-fpm/error.log"
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
default[:php][:fpm][:process_max] = 16
#
# Used to pass in php-fpm pools that need setting up
# Depends on php[fpm] recipe
default[:php][:fpm][:pools] = []
# If you disable the default, shared www pool, make sure that you have at least
# one other pool defined, otherwise php-fpm will fail to initialize. The only
# way to fix it would be to define a pool manually. Chef run won't complete otherwise.
default[:php][:fpm][:default_pool] = true

### Logrotation settings
#
default[:php][:fpm][:logrotate][:manage]        = true
default[:php][:fpm][:logrotate][:period]        = "daily"
default[:php][:fpm][:logrotate][:keep]          = 7
default[:php][:fpm][:logrotate][:mode]          = "0600"
# php-fpm master runs as root
default[:php][:fpm][:logrotate][:user]          = "root"
default[:php][:fpm][:logrotate][:group]         = "root"
default[:php][:fpm][:logrotate][:copytruncate]  = true



########################################################################### SUHOSIN #
#
default[:php][:suhosin][:session_cryptdocroot] = 'On'
default[:php][:suhosin][:memory_limit] = '64M'
