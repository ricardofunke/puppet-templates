class java::config{

  $javabasedir = '/opt/jvm'
  
  case $java::version {
      '6': { 
        $javaupdate = '45'
        $javahome = "${javabasedir}/${java::type}1.6.0_${javaupdate}"
      }
      '7': {
        $javaupdate = '80'
        $javahome = "${javabasedir}/${java::type}1.7.0_${javaupdate}"
      }
      '8': {
        $javaupdate = '92'
        $javahome = "${javabasedir}/${java::type}1.8.0_${javaupdate}"
      }
      default: {
        fail("unsupported vesion java ${java::version}")
      }
  }  
    
  case $::architecture {
      'i386':            { $arch = 'i586' }
      'x86_64', 'amd64': { $arch = 'x64' }
      default: {
        fail ("unsupported platform ${::architecture}")
      }
  }

  $javarel = "${java::type}-${java::version}u${javaupdate}-${java::os}-${arch}"

  case $::operatingsystem {
       'Ubuntu': { 
         $package_name = "${javarel}.tar.gz"
         $install_command = "sudo tar -C ${javabasedir} -zxvf /tmp/${package_name}" 
       }
       'Windows': { 
         $package_name = "${javarel}.exe"
         $install_command = "${javarel}.exe"
       }
       default: {
         fail ("unsupported OS ${::operatingsystem}")
       }
  }
  
}
