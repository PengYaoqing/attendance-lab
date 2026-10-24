# 使用带有 Java 11 的官方 Tomcat 9 镜像
FROM tomcat:9.0-jdk11-corretto

# 删除默认的 Tomcat 欢迎应用程序（可选）
RUN rm -rf /usr/local/tomcat/webapps/ROOT \
           /usr/local/tomcat/webapps/docs \
           /usr/local/tomcat/webapps/examples \
           /usr/local/tomcat/webapps/host-manager \
           /usr/local/tomcat/webapps/manager

# 将你的 war 文件复制到 Tomcat 的 webapps 目录下
COPY attendance.war /usr/local/tomcat/webapps/

# 将启动脚本复制到镜像中，并赋予可执行权限
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

# 暴露 8080 端口
EXPOSE 8080

# 使用我们的脚本启动 Tomcat
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]