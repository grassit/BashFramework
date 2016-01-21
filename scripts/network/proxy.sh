
declare -r PROXY_PORT=3128
declare -r PROXY_URL='localhost'
declare -r APT_PROXY_CONF='/etc/apt/apt.conf.d/95proxies'

cntlm_start() {
	sudo cntlm -v > /var/log/cntlm.log 2>&1 &
}

proxy_set() {
	gsettings set org.gnome.system.proxy mode 'manual' 
    gsettings set org.gnome.system.proxy.http host $PROXY_URL
    gsettings set org.gnome.system.proxy.http port $PROXY_PORT
    gsettings set org.gnome.system.proxy.https host $PROXY_URL
    gsettings set org.gnome.system.proxy.https port $PROXY_PORT

    http_proxy=http://$PROXY_URL:$PROXY_PORT/
	https_proxy=http://$PROXY_URL:$PROXY_PORT/
	HTTP_PROXY=http://$PROXY_URL:$PROXY_PORT/
	HTTPS_PROXY=http://$PROXY_URL:$PROXY_PORT/

	echo "Acquire::http::Proxy \"http://$PROXY_URL:$PROXY_PORT\";" \> $APT_PROXY_CONF	
	echo "Acquire::http::Proxy \"http://$PROXY_URL:$PROXY_PORT\";" > $APT_PROXY_CONF
}

# TODO: Remove apt-proxy as well
proxy_unset() {
	unset http_proxy
	unset https_proxy
	unset HTTP_PROXY
	unset HTTPS_PROXY

	gsettings reset-recursively org.gnome.system.proxy

	echo rm $APT_PROXY_CONF
	rm $APT_PROXY_CONF
}

proxy_show() {
	gsettings list-recursively org.gnome.system.proxy
}