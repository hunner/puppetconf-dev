node default {
  $email = extractvalue("/tmp/emails.yaml", "joe")
  notify { "emails":
    message => "Email is ${email}",
  }

  file { "/tmp/foo":
    ensure => file,
    mode   => '0644',
    owner  => '0',
    group  => '0',
  }

  file { "/tmp/bar":
    ensure => directory,
    mode   => '0755',
    owner  => '0',
    group  => '0',
  }
}
