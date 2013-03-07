class munin-node
{
    package {
        'munin-node':
            ensure => 'installed',
            provider => 'yum',
            require => Yumrepo['epel'];
    }

    file {
        '/etc/munin/munin-node.conf':
            ensure => present,
            mode   => 0644,
            owner  => 'root',
            group  => 'root',
            source => "puppet:///modules/munin-node/munin-node.conf",
            require => Package['munin-node'];
    }

    service {
        # Machine stats that can be polled very easily
        'munin-node':
            ensure => true,
            enable => true,
            require => [
                Package['munin-node'],
                File['/etc/munin/munin-node.conf']
            ],
            subscribe => [
                File['/etc/munin/munin-node.conf'],
                Package['munin-node']
            ];
    }

}