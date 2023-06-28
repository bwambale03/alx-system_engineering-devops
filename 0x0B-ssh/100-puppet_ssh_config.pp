file { '/etc/ssh/ssh_config':
  ensure  => present,
  content => "
    # Puppet-managed configuration file
    Host *
      IdentityFile ~/.ssh/school
      PasswordAuthentication no
  ",
}
