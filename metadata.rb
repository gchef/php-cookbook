maintainer        "Gerhard Lazu"
maintainer_email  "gerhard@lazu.co.uk"
license           "Apache 2.0"
description       "PHP5 Precise (12.04) backport for Lucid (10.04) & Oneiric (11.04)"
version           "0.1.0"

recipe "php", "Adds new apt repository, installs/uninstalls PHP5 packages and provides the default php.ini"

supports "ubuntu"

depends "apt"
