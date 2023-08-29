#!/bin/bash

PATH=$PATH:/home/cxsw/.local/bin/
origin_path=$PWD

#jeckin env
job_url="${JENKINS_URL}job/${JOB_NAME}"
job_display_name=$BUILD_DISPLAY_NAME
job_base_name=$JOB_BASE_NAME
now_time=$(date "+%Y-%m-%d %H:%M:%S")
git_branch=$GIT_BRANCH
webhook=$1

echo "jeckin env"
echo "origin_path" $origin_path
echo "job_url" $job_url
echo "job_display_name" $job_display_name
echo "now_time" $now_time
echo "job_base_name" $job_base_name
echo "git_branch" $git_branch

#compile
echo "compile"
python3 cmake/ci/conan-cmake.py -t linux
cd linux-build/build/
ninja all
cd $origin_path

#test
pwd
echo "run test"
python3 cmake/ci/algrithm-auto-check.py $webhook