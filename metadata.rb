name             "graphite"
maintainer       "Christian Nicolai"
maintainer_email "cn@mycrobase.de"
license          "Apache 2.0"
description      "Installs and configures carbon and/or graphite-webapp (including whisper)"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.1.0"

depends "python"

suggests "logrotate" # for graphite::logrotate

supports "debian"
