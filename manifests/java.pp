# Liferay Puppet Apache manifest
Class['apt-get-update'] -> Class['java'] 

include stdlib

class apt-get-update {
     Exec { path => "/bin:/usr/bin" }
     exec { "apt-get update":
		command => "apt-get update ; sudo apt-get install unzip",
        }
}

include apt-get-update
include java
