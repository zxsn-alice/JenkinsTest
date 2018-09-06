echo '============查看打包环境================' 
pwd
ls
echo $PATH   #进入jenkins工作目录 /var/jenkins_home/workspace/JenkinsTest
whoami
which dotnet
dotnet --info
dotnet --version
echo '============================begin restore======================================='
cd ./JenkinsTest/JenkinsTest
dotnet restore
echo '============================end restore======================================='
echo '============================cd project======================================='

echo '============================begin build======================================='
dotnet build # 为了生成XML注释文件 用于swagger注释

dotnet publish -c:Release -o ./bin/Release/netcoreapp2.1/publish # 如果针对给定运行时发布项目带上-r 如：-r centos.7-x64
cp ./bin/Debug/netcoreapp2.1/JenkinsTest.xml ./bin/Release/netcoreapp2.1/publish/ # 拷贝swagger注释
echo '============================end build======================================='

echo '============删除原有容器和镜像================' 
docker stop jenkinstest
docker rm jenkinstest
docker rmi jenkinstest:lxq
echo '============================end delete======================================='

echo '============构建镜像 运行容器================' 
cd /var/jenkins_home/workspace/JenkinsTest/JenkinsTest/JenkinsTest  
docker build -t jenkinstest:lxq .
docker run -d -p 15000:5000 --name jenkinsTest jenkinstest:lxq
echo '============================end run images======================================='
