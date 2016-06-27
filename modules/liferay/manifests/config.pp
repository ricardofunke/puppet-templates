class liferay::config {

    $liferay_name    =   "liferay-portal-${liferay::version}-${liferay::app_server}-${liferay::app_version}"
    $liferay_home    =   "/home/vagrant/${liferay_name}"
    $app_server_home =   "${liferay_home}/${liferay::app_server}-${liferay::app_version}"
    $license         =   "license-portaldevelopment-developer-cluster-${liferay::version}-liferaycom.xml"
    $url_patch       =   "download.url=${liferay::http_server}/private/ee/fix-packs/"

    case $liferay::version {
        '6210':{
            case $liferay::app_server {
                'tomcat':{
                    case $liferay::app_version {
                        '7.0.62':{ 
                            $bundle_liferay = 'liferay-portal-tomcat-6.2-ee-sp14-20151105114451508.zip'
                            $bundle_version = "/6.2.10.15/${bundle_liferay}" 
                        }
                        '7.0.42':{ 
                            $bundle_liferay = 'liferay-portal-tomcat-6.2.10.1-ee-ga1-20131126141110470.zip' 
                            $bundle_version = "/6.2.10.1/${bundle_liferay}" 
                        }
                        default:{ 
                            notice ("${liferay::app_version} not supported")
                        }
                    }
                }
                'jboss':{
                    case $liferay::app_version {
                        '7.1.1':{
                            $bundle_liferay = 'liferay-portal-jboss-6.2-ee-sp14-20151105114451508.zip'
                            $bundle_version = "/6.2.10.15/${bundle_liferay}"
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
                            $bundle_liferay = 'liferay-portal-tomcat-6.1.30-ee-ga3-20130812170130063.zip'
                            $bundle_version =  "/6.1.30/${bundle_liferay}"
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
                            $bundle_version = 'none' 
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
                            $bundle_version = 'none' 
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
        }
        'jboss':{
            $start_command = "/bin/bash -c 'CATALINA_HOME=${app_server_home} ${app_server_home}/bin/standalone.sh -b 0.0.0.0"
        }
        default :{
            notice ("apserver not supported")
        }
    }
} 
