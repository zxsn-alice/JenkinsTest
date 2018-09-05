# 声明使用的基础镜像
FROM microsoft/dotnet:2.1-aspnetcore-runtime
# 将本地dotnet core 应用拷贝到 容器 /app/ 目录下
COPY /bin/Debug/netcoreapp2.1/Release/publish/ /app/ERPCore/
# 设置工作目录
WORKDIR ./app/ERPCore
# 设置导出端口
EXPOSE 5000
# 指定应用入口点
ENTRYPOINT ["dotnet", "JenkinsTest.dll"]
