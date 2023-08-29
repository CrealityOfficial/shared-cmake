import sys
import osSystem

origin_path = sys.path[0] + '/../../'
bin_path = origin_path + 'linux-build/bin/Release/'
webhook = sys.argv[1]

def execute_test(name):
    cmd = bin_path + name
    osSystem.system(cmd)
    print("webhook " + webhook)
    
    
#web hook
#echo "web hook"

#sfiless=$origin_path$/linux-build/bin/Release/out.csv
#chmod -R 777 $sfiless

#cont=$(cat $sfiless|sed ':label;N;s/\n/\\n/;b label')
#cont=${cont//,/------------->} 


#curl -X POST -H "Content-Type: application/json" \
#-d '{"msg_type":"post","content": {"post": {"zh_cn": {"title": "自动测试结果通知","content": [[{"tag": "text","text": "'"项目名称：$string2\n构建编号：第$BUILD_NUMBER次构建\n远程分支：$GIT_BRANCH\n构建状态：成功\n构建日期：$nowTime\n输出结果：\n$cont"'"}]]} } }}' \
#https://open.feishu.cn/open-apis/bot/v2/hook/7ffe1550-8904-4b09-9e59-b3aaf4224236