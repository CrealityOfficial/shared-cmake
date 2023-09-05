import sys
import os
import osSystem
import json
import requests
import platform
import subprocess
import csv
import FeiShu
from pathlib import Path

class AutoTestBench():
    def __init__(self):
        self.origin_path = Path(sys.path[0] + '/../../')
        self.bin_path = self.origin_path.joinpath('linux-build/bin/Release/')
        self.system = platform.system()
        self.JECKINS_INFO = eval(sys.argv[1])
        
        self.webhook = self.JECKINS_INFO['WEBHOOK']
        self.scp_url = self.JECKINS_INFO['RESULT_URL']
        if self.system == 'Windows':
            self.bin_path = self.origin_path.joinpath('win32-build/bin/Release/')
            
        self.print_info()
        self.reset_working_directory()

    def print_info(self):
        print("AutoTest jeckins info " + str(self.JECKINS_INFO))
        print("AutoTest origin_path: " + str(self.origin_path))
        print("AutoTest bin_path: " + str(self.bin_path))
        
    def reset_working_directory(self):
        osSystem.cd(str(self.bin_path))
    
    def execute(self, name, tests):
        datas = []
        for test in tests:
            exe_test = '{}/{} ./data/{}'.format(str(self.bin_path), 'unit_test_format_check', test) 
            ret, value = subprocess.getstatusoutput(exe_test)
            
            if ret == 0:
                data = {}
                data['input'] = test
                data['value'] = value
                datas.append(data)
                print(exe_test + " success!")
            else:
                print("subprocess.getstatusoutput error.")        
        
        return datas
        
    def clone_source(self, url):
        path = Path('data')
        if path.exists():
            osSystem.cd(str(path))
            osSystem.system("git pull")
        else:
            osSystem.system("git clone " + url + " data")
            
        self.reset_working_directory()
    
    def send_feishu_notice(self, notice):
        self.save_scp_csv(notice['datas'], notice['scp_url'])
        notice['url'] = self.webhook
        FeiShu.send_auto_test_notice(notice)
        
    def save_scp_csv(self, datas, url):
        csv_name = '{}/temp.csv'.format(str(self.bin_path))
        with open(csv_name, 'w', newline="") as f:
            writer = csv.writer(f)
            names = ['input', 'result', 'state']
            writer.writerow(names)
            csv_datas = []
            for data in datas:
                csv_data = [data['input'], data['value'], str(data['state'])]
                csv_datas.append(csv_data)
                
            writer.writerows(csv_datas)
            f.close()
        
        if self.system != "Windows":
            scp_cmd = 'scp {} {}'.format(csv_name, url)
            
            ret, value = subprocess.getstatusoutput(scp_cmd)   
            if ret == 0:
                print(scp_cmd + " success!")
            else:
                print(scp_cmd + " error.")
        
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
 
def send_col(text): 
    url = webhook
    headers = {"Content-Type": "text/plain"}
    data = json.loads(text)
    r = requests.post(url, headers=headers, json=data)
    return r.content
    
def execute_test(name):
    print(bin_path.replace('\\', '/'))

    cmd = bin_path + name
    osSystem.system(cmd)
    out_path = bin_path + 'out.json'
    content = open(out_path,errors='ignore').read() 
    data2 = send_col(content)
    