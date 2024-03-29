# codes
代码库

# 开发步骤(假设你已经会用Git,并且已经安装了Git工具)
1. 开发Git工具，到自己的工作空间，用Maven创建一个模块化的项目

2. 进入模块的父节点，在我的机器上的目录结构如下：
卷 软件 的文件夹 PATH 列表
卷序列号为 00B843E6 000D:9E2E
D:\DEV\WORKSPACE\IDEAPROJECTS\CODES
│  .gitignore
│  LICENSE
│  README.md
│
├─.idea
│  │  .name
│  │  compiler.xml
│  │  encodings.xml
│  │  misc.xml
│  │  modules.xml
│  │  uiDesigner.xml
│  │  vcs.xml
│  │  workspace.xml
│  │
│  ├─copyright
│  │      profiles_settings.xml
│  │
│  ├─dictionaries
│  │      Administrator.xml
│  │
│  └─libraries
│          Maven__junit_junit_4_11.xml
│          Maven__org_hamcrest_hamcrest_core_1_3.xml
│
├─batch
│  └─EnvironmentConfig
│      ├─backup
│      │      readme
│      │
│      ├─bin
│      │      epath.bat
│      │      evar.bat
│      │      init-epath-revert.bat
│      │      init-epath.bat
│      │      init-evar-revert.bat
│      │      init-evar.bat
│      │      init-revert.bat
│      │      init.bat
│      │
│      ├─conf
│      │      epath.conf
│      │      evar.conf
│      │
│      └─logs
│              readme
│
├─codes-common
│  │  .gitignore
│  │  codes-common.iml
│  │  pom.xml
│  │
│  ├─src
│  │  ├─main
│  │  │  ├─java
│  │  │  └─resources
│  │  └─test
│  │      └─java
│  │          └─com
│  │              └─test
│  │                      JunitTest.java
│  │
│  └─target
│      │  codes-common-1.0-sources.jar
│      │  codes-common-1.0-sources.jar.asc
│      │  codes-common-1.0.jar
│      │  codes-common-1.0.jar.asc
│      │  codes-common-1.0.pom
│      │  codes-common-1.0.pom.asc
│      │
│      ├─classes
│      │  └─com
│      │      └─test
│      │              JunitTest.class
│      │
│      ├─generated-test-sources
│      │  └─test-annotations
│      ├─javadoc-bundle-options
│      │      javadoc-options-javadoc-resources.xml
│      │
│      ├─maven-archiver
│      │      pom.properties
│      │
│      └─maven-status
│          └─maven-compiler-plugin
│              ├─compile
│              │  └─default-compile
│              │          inputFiles.lst
│              │
│              └─testCompile
│                  └─default-testCompile
│                          createdFiles.lst
│                          inputFiles.lst
│
└─codes-parent
    │  .gitignore
    │  codes-parent.iml
    │  pom.xml
    │
    └─target
            codes-parent-1.0.pom
            codes-parent-1.0.pom.asc



3. 进入codes目录，执行 git init 命令

4. 执行 git remote add origin git@github.com:zhangguangyong/codes.git 命令关联关联github上面的仓库

5. 自行 git pull origin master 更新刚刚关联github上的codes.git仓库

6. 提交本地的更新
git add .
git commit -m 'xxxxxxxxx'
git push origin master



# 发布到Maven中央仓库
1. 单独发布某个子项目，进入子项目执行：
mvn clean deploy -P release

2. 发布父项目下面的所有子项目，进入父项目执行：
mvn clean deploy -P release
2.1 如果出现错误：

Event: Failed: Signature Validation
typeId	signature-staging
failureMessage	Invalid Signature: '/com/github/zhangguangyong/codes-common/1.0/codes-common-1.0-sources.jar.asc' is not a valid signature for 'codes-common-1.0-sources.jar'.

解决方案：注释掉<parent> 节点，再发布
<!--
<parent>
    <artifactId>codes-parent</artifactId>
    <groupId>com.github.zhangguangyong</groupId>
    <version>1.0</version>
    <relativePath>../codes-parent/pom.xml</relativePath>
</parent>

<artifactId>codes-common</artifactId>
<packaging>jar</packaging>
-->

<groupId>com.github.zhangguangyong</groupId>
<artifactId>codes-common</artifactId>
<version>1.0</version>
<packaging>jar</packaging>


3. 查看发布的记录，登陆自己在sonatype网站注册用户名密码
https://oss.sonatype.org/

3.1 进入 https://oss.sonatype.org/ 登陆自己的账号，找到自己刚刚发布的构件，进行关闭和发布操作通知sonatype网站的工作人员

3.2 进入 http://search.maven.org/ 上搜索自己的构件
