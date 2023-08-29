#!/bin/bash

PATH=$PATH:/home/cxsw/.local/bin/

origin_path=$PWD

#path
echo "print path:"
echo $origin_path

#compile
echo "compile"
git submodule update --init
python3 cmake/ci/conan-cmake.py -t linux
cd linux-build/build/
ninja all
cd $origin_path

#test
echo "test"

/bin/Release/unit_test_format

JOB_URL="${JENKINS_URL}job/${JOB_NAME}"

string1=$BUILD_DISPLAY_NAME
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

