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
# 【新增】：用只输出到控制台的配置，覆盖掉默认写文件的配置
COPY logging.properties /usr/local/tomcat/conf/logging.properties

# 修复脚本换行符并赋予执行权限
RUN sed -i 's/\r$//' /usr/local/bin/entrypoint.sh && chmod +x /usr/local/bin/entrypoint.sh

# 创建可写的临时目录和日志目录（防止 Tomcat 尝试写系统根目录）
RUN mkdir -p /usr/local/tomcat/writable-logs /usr/local/tomcat/writable-temp && \
    chmod -R 777 /usr/local/tomcat/writable-logs /usr/local/tomcat/writable-temp

# 暴露 8080 端口
EXPOSE 8080

# 使用我们的脚本启动 Tomcat
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
