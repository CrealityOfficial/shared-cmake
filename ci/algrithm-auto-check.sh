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
job_url="${JENKINS_URL}job/${JOB_NAME}"
job_display_name=$BUILD_DISPLAY_NAME

echo job_url
echo job_display_name


#web hook
echo "web hook"
string1=$job_display_name
string2=$JOB_BASE_NAME
nowTime=$(date "+%Y-%m-%d %H:%M:%S")

CRTDIR=$(pwd)
s1='/linux-build/bin/Release/out.csv'
sfiless=$CRTDIR$s1

chmod -R 777 $sfiless

cont=$(cat $sfiless|sed ':label;N;s/\n/\\n/;b label')
cont=${cont//,/------------->} 


curl -X POST -H "Content-Type: application/json" \
-d '{"msg_type":"post","content": {"post": {"zh_cn": {"title": "�Զ����Խ��֪ͨ","content": [[{"tag": "text","text": "'"��Ŀ���ƣ�$string2\n������ţ���$BUILD_NUMBER�ι���\nԶ�̷�֧��$GIT_BRANCH\n����״̬���ɹ�\n�������ڣ�$nowTime\n��������\n$cont"'"}]]} } }}' \
https://open.feishu.cn/open-apis/bot/v2/hook/7ffe1550-8904-4b09-9e59-b3aaf4224236

