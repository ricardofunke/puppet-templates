class liferay::run {
    
    exec { 'liferay_start':
        require      =>  Class['java::install'],
        path         =>  ["/opt/jvm/java/bin", "/usr/bin", "/bin"],
#        environment  =>  "JAVA_HOME=/opt/jvm/java",
        command      =>  "${liferay::config::start_command}",
        user	     =>  'vagrant',
        provider     => shell,
    }
	
    notify { 'run_notification':
        require =>  Exec['liferay_start'],
        name    =>  'run notification',
        message =>  "${liferay::config::start_command} was executed from ${liferay::config::app_server_home}",
    }
}  
