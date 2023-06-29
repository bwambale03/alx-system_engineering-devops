#setting up my client config file
include stdlib

file_line { 'Turn off passwd auth':
  ensure = present,
  path  => '/etc/ssh/sshd_config',
  line  => 'PasswordAuthentication no',
  match => '^#?PasswordAuthentication\s+',
  replace => true,
}

file_line { 'Declare identity file':
   ensure = present,
  path  => '/etc/ssh/ssh_config',
  line  => 'IdentityFile ~/.ssh/school',
  match => '^#?IdentityFile\s+',
  replace => true,
}

