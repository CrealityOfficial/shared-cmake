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
        self.commit_id = self.JECKINS_INFO['COMMIT_ID']
        self.job_name = self.JECKINS_INFO['JOB_NAME']
        self.user = self.JECKINS_INFO['USER']
        self.url = self.JECKINS_INFO['URL']
        self.scp_url = '{}:{}/{}/'.format(self.user, self.url, self.job_name)
        
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
        self.save_scp_csv(notice['datas'])
        notice['url'] = self.webhook
        notice['scp_url'] = self.scp_url
        FeiShu.send_auto_test_notice(notice)
        
    def save_scp_csv(self, datas):
        csv_name = '{}/temp.csv'.format(str(self.bin_path))
        with open(csv_name, 'w', encoding='utf-8-sig', newline="") as f:
            writer = csv.writer(f)
            names = ['input', 'result', 'state']
            writer.writerow(names)
            csv_datas = []
            for data in datas:
                csv_data = [data['input'], data['value'], str(data['state'])]
                csv_datas.append(csv_data)
                
            writer.writerows(csv_datas)
            f.close()
        
        scp_cmd = 'scp {} {}/{}.csv'.format(csv_name, self.scp_url, self.commit_id)            
        ret, value = subprocess.getstatusoutput(scp_cmd)   
        if ret == 0:
            print(scp_cmd + " success!")
        else:
            print(scp_cmd + " error.")         
        