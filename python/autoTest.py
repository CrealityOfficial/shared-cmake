import sys
import osSystem
import json
import requests

origin_path = sys.path[0] + '/../../'
bin_path = origin_path + 'linux-build/bin/Release/'
webhook = sys.argv[1]

def send_text(Text):
    """发送普通消息"""
    url = webhook
    headers = {"Content-Type": "text/plain"}
    data = {
        "msg_type": "text",
        "content": {
            "text": Text
        }
    } 
    r = requests.post(url, headers=headers, json=data)
    return r.text

def send_markdown(text):
    """发送富文本消息"""
    url = webhook
    headers = {"Content-Type": "text/plain"}
    data = {
        "msg_type": "interactive",
        "card": {
  "config": {
    "wide_screen_mode": True
  },
  "header": {
    "title": {
      "tag": "plain_text",
      "content": "你有一个休假申请待审批"
    }
  },
  "elements": [
    {
      "tag": "div",
      "fields": [
        {
          "is_short": True,
          "text": {
            "tag": "lark_md",
            "content": "**申请人**\n王晓磊"
          }
        },
        {
          "is_short": True,
          "text": {
            "tag": "lark_md",
            "content": "**休假类型：**\n年假"
          }
        },
        {
          "is_short": False,
          "text": {
            "tag": "lark_md",
            "content": ""
          }
        },
        {
          "is_short": False,
          "text": {
            "tag": "lark_md",
            "content": "**时间：**\n2020-4-8 至 2020-4-10（共3天）"
          }
        },
        {
          "is_short": False,
          "text": {
            "tag": "lark_md",
            "content": ""
          }
        },
        {
          "is_short": True,
          "text": {
            "tag": "lark_md",
            "content": "**备注**\n因家中有急事，需往返老家，故请假"
          }
        }
      ]
    },
    {
      "tag": "note",
      "elements": [
        {
          "tag": "img",
          "img_key": "img_b79d3e29-5ffe-4897-822a-9743fe9f7b1g",
          "alt": {
            "tag": "plain_text",
            "content": "图片"
          }
        },
        {
          "tag": "plain_text",
          "content": "已同意休假申请"
        }
      ]
    }
  ]
        }
    } 
    r = requests.post(url, headers=headers, json=data)
    return r.text

def send_card(Text):
    """发送卡片消息"""
    url = webhook
    headers = {"Content-Type": "text/plain"}
    data = {
        "msg_type": "interactive",
        "card": Text
    } 
    r = requests.post(url, headers=headers, json=data)
    return r.text
    
def execute_test(name):
    cmd = bin_path + name
    osSystem.system(cmd)
   
    send_markdown("hello")  
    
#web hook
#echo "web hook"

#sfiless=$origin_path$/linux-build/bin/Release/out.csv
#chmod -R 777 $sfiless

#cont=$(cat $sfiless|sed ':label;N;s/\n/\\n/;b label')
#cont=${cont//,/------------->} 


#curl -X POST -H "Content-Type: application/json" \
#-d '{"msg_type":"post","content": {"post": {"zh_cn": {"title": "自动测试结果通知","content": [[{"tag": "text","text": "'"项目名称：$string2\n构建编号：第$BUILD_NUMBER次构建\n远程分支：$GIT_BRANCH\n构建状态：成功\n构建日期：$nowTime\n输出结果：\n$cont"'"}]]} } }}' \
#https://open.feishu.cn/open-apis/bot/v2/hook/7ffe1550-8904-4b09-9e59-b3aaf4224236