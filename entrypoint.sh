#!/bin/bash
ln -sf /usr/local/tomcat/writable-logs /usr/local/tomcat/logs
ln -sf /usr/local/tomcat/writable-temp /usr/local/tomcat/temp

# 替换端口
if [ -n "$PORT" ] && [ "$PORT" != "8080" ]; then
    sed -i "s/port=\"8080\"/port=\"\$PORT\"/" "$CATALINA_HOME/conf/server.xml"
fi

# 启动 Tomcat
exec "$CATALINA_HOME/bin/catalina.sh" run
