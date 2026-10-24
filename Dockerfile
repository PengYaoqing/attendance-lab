# 使用带有 Java 11 的官方 Tomcat 9 镜像
FROM tomcat:9.0-jdk11-corretto

# 删除默认的 Tomcat 欢迎应用程序
RUN rm -rf /usr/local/tomcat/webapps/ROOT \
           /usr/local/tomcat/webapps/docs \
           /usr/local/tomcat/webapps/examples \
           /usr/local/tomcat/webapps/host-manager \
           /usr/local/tomcat/webapps/manager

# 将 war 文件复制到 Tomcat 的 webapps 目录下
COPY attendance.war /usr/local/tomcat/webapps/

# 将启动脚本和日志配置复制到镜像中
COPY entrypoint.sh /usr/local/bin/
COPY logging.properties /usr/local/tomcat/conf/logging.properties

# 修复脚本换行符并赋予执行权限
RUN sed -i 's/\r$//' /usr/local/bin/entrypoint.sh && chmod +x /usr/local/bin/entrypoint.sh

# 【关键修改】：同时创建 logs、temp 和 work 的可写目录
RUN mkdir -p /usr/local/tomcat/writable-logs /usr/local/tomcat/writable-temp /usr/local/tomcat/writable-work && \
    chmod -R 777 /usr/local/tomcat/writable-logs /usr/local/tomcat/writable-temp /usr/local/tomcat/writable-work

# 暴露 8080 端口
EXPOSE 8080

# 使用我们的脚本启动 Tomcat
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
