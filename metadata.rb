name             "opsworks_que"
maintainer       "Tanga"
maintainer_email "dev@tanga.com"
license          "MIT"
description      "Configure and deploy background job workers using que."
version          "0.8.1"

recipe 'opsworks_que::setup', 'Set up que worker.'
recipe 'opsworks_que::configure', 'Configure que worker.'
recipe 'opsworks_que::deploy', 'Deploy que worker.'
recipe 'opsworks_que::undeploy', 'Undeploy que worker.'
recipe 'opsworks_que::stop', 'Stop que worker.'

# An explicit dependency on Opsworks' deploy cookbook was necessary with Chef <11.10,
# but this isn't compatible with Berkshelf.
# depends 'deploy'

depends 'supervisor'
