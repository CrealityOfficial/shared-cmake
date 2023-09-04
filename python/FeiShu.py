# -*- coding: utf-8 -*-
import requests
import sys
import os
class SendNotice():
    def __init__(self, data):
        #self.INFO = eval(sys.argv[1])
        #self.INFO = argv_dic
        #self.JOB_URL = self.INFO['BUILD_URL']  #项目地址路径
        #self.JOB_NAME = self.INFO['JOB_NAME']  #项目名称
        #self.BUILD_NUMBER = self.INFO['BUILD_NUMBER'] #构建次数
        #self.BUILD_TIME = self.INFO['BUILD_TIME']  # 构建时间
        
        self.url = data['url']
        self.name = data['name']
        self.result_url = data['result_url']
        self.divs = data['divs']
        self.method = 'post'
        self.headers = {
            'Content-Type': 'application/json'
        }
        self.json = {
            "msg_type": "interactive",
            "card": {
                "config": {
                    "wide_screen_mode": True,
                    "enable_forward": True
                },
                "elements": [{
                    "actions": [{
                        "tag": "button",
                        "text": {
                            "content": "查看测试报告",
                            "tag": "lark_md"
                        },
                        "url": self.result_url,
                        "type": "default",
                        "value": {}
                    }
                    ],
                    "tag": "action"
                }],
                "header": {
                    "title": {
                        "content": self.name,
                        "tag": "plain_text"
                    }
                }
            }
        }
        
        self.json['card']['elements'] = self.divs + self.json['card']['elements']

    def send_feishu(self):
        requests.request(method=self.method, url=self.url, headers=self.headers, json=self.json)

