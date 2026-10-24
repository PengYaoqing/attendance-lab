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

# 将启动脚本复制到镜像中
COPY entrypoint.sh /usr/local/bin/

# 修复 Windows 的换行符问题，并赋予执行权限
RUN sed -i 's/\r$//' /usr/local/bin/entrypoint.sh && chmod +x /usr/local/bin/entrypoint.sh

# 【新增】：创建可写的 logs 和 temp 目录，并赋予权限
RUN mkdir -p /usr/local/tomcat/writable-logs /usr/local/tomcat/writable-temp && \
    chmod -R 777 /usr/local/tomcat/writable-logs /usr/local/tomcat/writable-temp

# 暴露 8080 端口
EXPOSE 8080

# 使用我们的脚本启动 Tomcat
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
