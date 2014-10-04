function start-cocproxy () {
	if [ -s /tmp/cocproxy.pid ]; then
		echo "cocproxy が既に起動しています。"
		echo "-- ps --"
		ps -A |grep /usr/local/bin/proxy.rb |grep -v grep
		echo "-- netstat --"
		netstat -anp 2> /dev/null |grep 5432
		return 1
	fi
	nohup /usr/local/bin/proxy.rb throwaway &
	if [ $? -eq  1 ]; then
		echo "cocproxyの起動に失敗しました。既に起動しているかもしれません。"
		echo "-- ps --"
		ps -A |grep /usr/local/bin/proxy.rb |grep -v grep
		echo "-- netstat --"
		netstat -anp 2> /dev/null |grep 5432
		return 1
	fi
	echo $! > /tmp/cocproxy.pid
}

function stop-cocproxy () {
	if [ -s /tmp/cocproxy.pid ]; then
		kill `cat /tmp/cocproxy.pid`
		rm --interactive=never /tmp/cocproxy.pid
	fi
}
