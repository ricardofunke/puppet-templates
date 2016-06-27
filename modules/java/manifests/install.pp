class java::install{
    
    file { "${java::config::javabasedir}":
		ensure	=> directory,
    }    

    exec {'downloadJava':
        require =>  File["${java::config::javabasedir}"], 
        path    =>  '/bin:/usr/bin',
        command =>  "wget http://192.168.110.251/java/${java::config::package_name} -P /tmp",
        creates =>  "/tmp/${java::config::package_name}",
    }

    exec {'unpackJava': 
        require =>  Exec['downloadJava'],
        path    =>  '/bin:/usr/bin',
        command =>  "${java::config::install_command}",
        creates =>  "${java::config::javahome}",
    }

    file {"${java::config::javabasedir}/java":
        require =>  Exec['unpackJava'],
        ensure  =>  link,
        target  =>  "${java::config::javahome}"
    }

    file {'/etc/profile.d/java.sh':
        require =>  File["${java::config::javabasedir}/java"],
        ensure  =>  'present',
        replace =>  'no',
        content =>  "export PATH=\${PATH}:${java::config::javahome}/bin\n",
        mode    =>  '0755',
        owner   =>  'root',
        group   =>  'root',
    }

    notify{'mensajeDone':
        require =>  File['/etc/profile.d/java.sh'],
        name    =>  'install notification',
        message =>  "${java::config::javarel} installed successfully!!!",
    }

}
