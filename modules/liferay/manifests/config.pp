class liferay::config {

    $liferay_name    =   "liferay-portal-${liferay::version}-${liferay::app_server}-${liferay::app_version}"
    $liferay_home    =   "/home/vagrant/${liferay_name}"
    $app_server_home =   "${liferay_home}/${liferay::app_server}-${liferay::app_version}"
    $license         =   "license-portaldevelopment-developer-cluster-${liferay::version}-liferaycom.xml"
    $url_patch       =   "download.url=${liferay::http_server}/private/ee/fix-packs/"

    case $liferay::db_type {
        'mysql':{
            $db_driver_name = 'mysql-connector-java-5.1.39-bin.jar'
        }
        'db2':{
            $db_driver_name = 'db2jcc.jar'
        }
        'oracle':{
            case $java::version {
                '6':{
                    $db_driver_name = 'ojdbc6.jar'
                }
                '7':{
                    $db_driver_name = 'ojdbc7.jar'
                }
            }
        }
        'postgresql':{
            $db_driver_name = 'postgresql-9.4.1208.jre6.jar'
        }
        'mssql':{
            $db_driver_name = 'jtds.jar'
        }
        'sybase':{
            $db_driver_name = 'jtds.jar'
        }
        default:{ 
            notice ("${liferay::db_type} not supported")
        }
    }
    
    
    case $liferay::version {
        '7010':{
            case $liferay::app_server {
                'tomcat':{
                    case $liferay::app_version {
                        '8.0.32':{ 
                            $bundle_liferay = 'liferay-dxp-digital-enterprise-tomcat-7.0-sp1-20161027112321352.zip'
                            $bundle_version = "7.0.10.1/${bundle_liferay}" 
                        }
                        default:{ 
                            notice ("${liferay::app_version} not supported")
                        }
                    }
                }
                'jboss':{
                    case $liferay::app_version {
                        'eap-6.4':{
                            $bundle_liferay = 'liferay-dxp-digital-enterprise-jboss-eap-6.4-7.0-sp1-20161027112321352.zip'
                            $bundle_version = "7.0.10.1/${bundle_liferay}"
                        }
                        default:{ 
                            notice ("${liferay::app_version} not supported")
                        }
                    }
                }
                default :{
                    notice ("apserver not supported")
                }
            }
        }
        '6210':{
            case $liferay::app_server {
                'tomcat':{
                    case $liferay::app_version {
                        '7.0.62':{ 
                            $bundle_liferay = 'liferay-portal-tomcat-6.2-ee-sp14-20151105114451508.zip'
                            $bundle_version = "6.2.10.15/${bundle_liferay}" 
                        }
                        '7.0.42':{ 
                            $bundle_liferay = 'liferay-portal-tomcat-6.2.10.1-ee-ga1-20131126141110470.zip' 
                            $bundle_version = "6.2.10.1/${bundle_liferay}" 
                        }
                        default:{ 
                            notice ("${liferay::app_version} not supported")
                        }
                    }
                }
                'jboss':{
                    case $liferay::app_version {
                        '7.1.1':{
                            $bundle_liferay = 'liferay-portal-jboss-6.2-ee-sp1-20140204095606875.zip'
                            $bundle_version = "6.2.10.2/${bundle_liferay}"
                        }
                        default:{ 
                            notice ("${liferay::app_version} not supported")
                        }
                    }
                }
                default :{
                    notice ("apserver not supported")
                }
            }
        }
        '6130':{
            case $liferay::app_server {
                'tomcat':{
                    case $liferay::app_version {
                        '7.0.40':{ 
                            $bundle_liferay = 'liferay-portal-tomcat-6.1-ee-ga3-sp5-20160201142343123.zip'
                            $bundle_version =  "6.1.30.5/${bundle_liferay}"
                        }
                        default:{ 
                            notice ("${liferay::app_version} not supported")
                        }
                    }
                }
                'jboss':{
                    case $liferay::app_version {
                        '7.1.1':{
                            $bundle_liferay = 'liferay-portal-jboss-6.1-ee-ga3-sp5-20160201142343123.zip'
                            $bundle_version = "6.1.30.5/${bundle_liferay}"
                        }
                        default:{ 
                            notice ("${liferay::app_version} not supported")
                        }
                    }
                }
                default :{
                    notice ("apserver not supported")
                }
            }
        }
        '6120':{
            case $liferay::app_server {
                'tomcat':{
                    case $liferay::app_version {
                        '7.0.27':{ 
                            $bundle_liferay = 'liferay-portal-tomcat-6.1.20-ee-ga2-20120731110418084.zip' 
                            $bundle_version = "6.1.20/${bundle_liferay}"
                        }
                        default:{ 
                            notice ("${liferay::app_version} not supported")
                        }
                    }
                }
                'jboss':{
                    case $liferay::app_version {
                        '7.1.1':{
                            $bundle_liferay = 'liferay-portal-jboss-6.1.20-ee-ga2-20120731110418084.zip'
                            $bundle_version = "6.1.20/${bundle_liferay}"
                        }
                        default:{ 
                            notice ("${liferay::app_version} not supported")
                        }
                    }
                }
                default :{
                    notice ("apserver not supported")
                }
            }
        }
        '6110':{
            case $liferay::app_server {
                'tomcat':{
                    case $liferay::app_version {
                        '7.0.25':{ 
                            $bundle_liferay = 'liferay-portal-tomcat-6.1.10-ee-ga1-20120217120951450.zip' 
                            $bundle_version = "6.1.10/${bundle_liferay}"
                        }
                        default:{ 
                            notice ("${liferay::app_version} not supported")
                        }
                    }
                }
                'jboss':{
                    case $liferay::app_version {
                        '7.0.2':{
                            $bundle_liferay = 'liferay-portal-jboss-6.1.10-ee-ga1-20120223174854827.zip'
                            $bundle_version = "6.1.10/${bundle_liferay}"
                        }
                        default:{ 
                            notice ("${liferay::app_version} not supported")
                        }
                    }
                }
                default :{
                    notice ("apserver not supported")
                }
            }
        }
    }
    
    case $liferay::app_server {
        'tomcat':{
            $start_command = "/bin/bash -c 'CATALINA_HOME=${app_server_home} ${app_server_home}/bin/catalina.sh start'"
            $db_driver_home = "${app_server_home}/lib/ext"
            $configure_db   = "echo 'driver installed'"
        }
        'jboss':{
            $start_command = "${app_server_home}/bin/standalone.sh -b 0.0.0.0 &"
            $db_driver_home = "${app_server_home}/modules/com/liferay/portal/main"
            $configure_db   = "sed \'7a <resource-root path=\"${db_driver_name}/\" />\' ${db_driver_home}/module.xml > /tmp/test.xml && rm ${db_driver_home}/module.xml && mv /tmp/test.xml ${db_driver_home}/module.xml"  
#            $start_command = "/bin/bash -c 'CATALINA_HOME=${app_server_home} ${app_server_home}/bin/standalone.sh -b 0.0.0.0"
        }
        default :{
            notice ("apserver not supported")
        }
    }
} 
