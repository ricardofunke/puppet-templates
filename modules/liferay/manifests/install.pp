class liferay::install {
    
    exec { 'downloadLiferay':
        path    =>  '/bin:/usr/bin',
        command =>  "wget ${liferay::http_server}/private/ee/portal/${liferay::config::bundle_version} -P /tmp",
        creates =>  "/tmp/${liferay::config::bundle_version}",
        user    =>  'vagrant',
    }        

    exec { 'unzipLiferay':
        require =>  Exec['downloadLiferay'],
        path    =>  '/bin:/usr/bin',
        command =>  "unzip -qq /tmp/${liferay::config::bundle_liferay}",
        cwd     =>  '/home/vagrant',
	user	=>  'vagrant',
    }
 
    exec { 'renameLiferayHome':
        require =>  Exec['unzipLiferay'],
        path    =>  '/bin:/usr/bin',
        command =>  "mv liferay-portal* ${liferay::config::liferay_name}",
        cwd     =>  '/home/vagrant',
        user    =>  'vagrant',
    }

    file { 'removePatchingTool':
        require =>  Exec['renameLiferayHome'],
        ensure  =>  absent,
        path    =>  "${liferay::config::liferay_home}/patching-tool",
        recurse =>  true,
        purge   =>  true,
        force   =>  true,
        }
    
    exec { 'downloadPatchingTool':
        path    =>  '/bin:/usr/bin',
        command =>  "wget ${liferay::http_server}/private/ee/fix-packs/patching-tool/patching-tool-${liferay::patching_tool_version}-internal.zip -P /tmp",
        creates =>  "/tmp/patching-tool-${liferay::patching_tool_version}-internal.zip",
        user    =>  'vagrant',
    }        

    exec { 'unzipPatchingTool':
	require =>  [ File['removePatchingTool'], Exec['downloadPatchingTool'] ],
        path    =>  '/bin:/usr/bin',
	command =>  "unzip -qq /tmp/patching-tool-${liferay::patching_tool_version}-internal.zip -d ${liferay::config::liferay_home}",
	user	=>  'vagrant',
    }
    
    file { "${liferay::config::liferay_home}/deploy":
	ensure	=>  directory,
        owner   =>  'vagrant',
    }
        
    exec { 'deployLicense':
	require =>  File["${liferay::config::liferay_home}/deploy"],
        path    =>  '/bin:/usr/bin',
        command =>  "wget ${liferay::http_server}/private/ee/portal/licenses/${liferay::config::license} -P ${liferay::config::liferay_home}/deploy/",
        creates =>  "${liferay::config::liferay_home}/deploy/${liferay::config::license}",
        user    =>  'vagrant',
    }

    file { "${liferay::config::liferay_home}/portal-ext.properties":
	require =>  Exec['unzipLiferay'],
	ensure	=>  present,
	source	=>  "/vagrant/portal-ext.properties",
	owner	=>  'vagrant',
	group	=>  'vagrant',
	mode	=>  '0644',
    }

    exec {'autoDiscoveryPatch':
        require =>  [ Exec['unzipPatchingTool'], Class['java::install'] ],
        path    =>  ['/opt/jvm/java/bin', '/bin', '/usr/bin'],
        command =>  "bash patching-tool.sh auto-discovery && echo \"${liferay::config::url_patch}\" >> default.properties && echo \"auto.update.plugins=true\" >> default.properties",
        cwd     =>  "${liferay::config::liferay_home}/patching-tool",
	user	=>  'vagrant',
    }

    exec {'installPatch':
        require =>  [ Exec['autoDiscoveryPatch'], Class['java::install'] ],
        path    =>  ['/opt/jvm/java/bin', '/bin', '/usr/bin'],
        command =>  "bash patching-tool.sh revert && bash patching-tool.sh download ${liferay::patch} && bash patching-tool.sh install",
        cwd     =>  "${liferay::config::liferay_home}/patching-tool",
	user	=>  'vagrant',
    }
}  
