# Render 会注入 PORT 环境变量。Tomcat 默认监听
# 8080 端口，所以当设置了 PORT 时，在启动前修改 server.xml。
if [ -n "$PORT" ] && [ "$PORT" != "8080" ]; then
    sed -i "s/port=\"8080\"/port=\"\$PORT\"/" \
    "$CATALINA_HOME/conf/server.xml"
fi
exec "$CATALINA_HOME/bin/catalina.sh" run
