#!/bin/bash

PATH=$PATH:/home/cxsw/.local/bin/

origin_path=$PWD

#path
echo "print path:"
echo $origin_path

#compile
echo "compile"
python3 cmake/ci/conan-cmake.py -t linux
cd linux-build/build/
ninja all
cd $origin_path

#test
pwd
echo "run test"

bin_path=$origin_path/linux-build/bin/Release/

$bin_path/unit_test_format 

#jeckin env
echo "jeckin env"
job_url="${JENKINS_URL}job/${JOB_NAME}"
job_display_name=$BUILD_DISPLAY_NAME
job_base_name=$JOB_BASE_NAME
now_time=$(date "+%Y-%m-%d %H:%M:%S")

echo $job_url
echo $job_display_name
echo $now_time
echo $job_base_name

#web hook
echo "web hook"
string1=$job_display_name
string2=$job_base_name


CRTDIR=$(pwd)
s1='/linux-build/bin/Release/out.csv'
sfiless=$CRTDIR$s1

chmod -R 777 $sfiless

cont=$(cat $sfiless|sed ':label;N;s/\n/\\n/;b label')
cont=${cont//,/------------->} 


curl -X POST -H "Content-Type: application/json" \
-d '{"msg_type":"post","content": {"post": {"zh_cn": {"title": "自动测试结果通知","content": [[{"tag": "text","text": "'"项目名称：$string2\n构建编号：第$BUILD_NUMBER次构建\n远程分支：$GIT_BRANCH\n构建状态：成功\n构建日期：$nowTime\n输出结果：\n$cont"'"}]]} } }}' \
https://open.feishu.cn/open-apis/bot/v2/hook/7ffe1550-8904-4b09-9e59-b3aaf4224236

