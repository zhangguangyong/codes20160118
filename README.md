# codes
�����

# ��������(�������Ѿ�����Git,�����Ѿ���װ��Git����)
1. ����Git���ߣ����Լ��Ĺ����ռ䣬��Maven����һ��ģ�黯����Ŀ

2. ����ģ��ĸ��ڵ㣬���ҵĻ����ϵ�Ŀ¼�ṹ���£�
�� ��� ���ļ��� PATH �б�
�����к�Ϊ 00B843E6 000D:9E2E
D:\DEV\WORKSPACE\IDEAPROJECTS\CODES
��  .gitignore
��  LICENSE
��  README.md
��
����.idea
��  ��  .name
��  ��  compiler.xml
��  ��  encodings.xml
��  ��  misc.xml
��  ��  modules.xml
��  ��  uiDesigner.xml
��  ��  vcs.xml
��  ��  workspace.xml
��  ��
��  ����copyright
��  ��      profiles_settings.xml
��  ��
��  ����dictionaries
��  ��      Administrator.xml
��  ��
��  ����libraries
��          Maven__junit_junit_4_11.xml
��          Maven__org_hamcrest_hamcrest_core_1_3.xml
��
����batch
��  ����EnvironmentConfig
��      ����backup
��      ��      readme
��      ��
��      ����bin
��      ��      epath.bat
��      ��      evar.bat
��      ��      init-epath-revert.bat
��      ��      init-epath.bat
��      ��      init-evar-revert.bat
��      ��      init-evar.bat
��      ��      init-revert.bat
��      ��      init.bat
��      ��
��      ����conf
��      ��      epath.conf
��      ��      evar.conf
��      ��
��      ����logs
��              readme
��
����codes-common
��  ��  .gitignore
��  ��  codes-common.iml
��  ��  pom.xml
��  ��
��  ����src
��  ��  ����main
��  ��  ��  ����java
��  ��  ��  ����resources
��  ��  ����test
��  ��      ����java
��  ��          ����com
��  ��              ����test
��  ��                      JunitTest.java
��  ��
��  ����target
��      ��  codes-common-1.0-sources.jar
��      ��  codes-common-1.0-sources.jar.asc
��      ��  codes-common-1.0.jar
��      ��  codes-common-1.0.jar.asc
��      ��  codes-common-1.0.pom
��      ��  codes-common-1.0.pom.asc
��      ��
��      ����classes
��      ��  ����com
��      ��      ����test
��      ��              JunitTest.class
��      ��
��      ����generated-test-sources
��      ��  ����test-annotations
��      ����javadoc-bundle-options
��      ��      javadoc-options-javadoc-resources.xml
��      ��
��      ����maven-archiver
��      ��      pom.properties
��      ��
��      ����maven-status
��          ����maven-compiler-plugin
��              ����compile
��              ��  ����default-compile
��              ��          inputFiles.lst
��              ��
��              ����testCompile
��                  ����default-testCompile
��                          createdFiles.lst
��                          inputFiles.lst
��
����codes-parent
    ��  .gitignore
    ��  codes-parent.iml
    ��  pom.xml
    ��
    ����target
            codes-parent-1.0.pom
            codes-parent-1.0.pom.asc



3. ����codesĿ¼��ִ�� git init ����

4. ִ�� git remote add origin git@github.com:zhangguangyong/codes.git �����������github����Ĳֿ�

5. ���� git pull origin master ���¸ոչ���github�ϵ�codes.git�ֿ�

6. �ύ���صĸ���
git add .
git commit -m 'xxxxxxxxx'
git push origin master



# ������Maven����ֿ�
1. ��������ĳ������Ŀ����������Ŀִ�У�
mvn clean deploy -P release

2. ��������Ŀ�������������Ŀ�����븸��Ŀִ�У�
mvn clean deploy -P release
2.1 ������ִ���

Event: Failed: Signature Validation
typeId	signature-staging
failureMessage	Invalid Signature: '/com/github/zhangguangyong/codes-common/1.0/codes-common-1.0-sources.jar.asc' is not a valid signature for 'codes-common-1.0-sources.jar'.

���������ע�͵�<parent> �ڵ㣬�ٷ���
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


3. �鿴�����ļ�¼����½�Լ���sonatype��վע���û�������
https://oss.sonatype.org/

3.1 ���� https://oss.sonatype.org/ ��½�Լ����˺ţ��ҵ��Լ��ոշ����Ĺ��������йرպͷ�������֪ͨsonatype��վ�Ĺ�����Ա

3.2 ���� http://search.maven.org/ �������Լ��Ĺ���
