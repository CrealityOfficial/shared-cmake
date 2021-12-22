#ifndef __CC_GLOBAL_LOG__
#define __CC_GLOBAL_LOG__

#if __ANDROID__
#include <android/log.h>

#define  LOGI(...)  __android_log_print(ANDROID_LOG_INFO,"NativeCC",__VA_ARGS__)
#define  LOGE(...)  __android_log_print(ANDROID_LOG_ERROR,"NativeCC",__VA_ARGS__)
#else

#include <stdarg.h>
#include <stdio.h>
#include <iostream>

#define LOGI(...) printf(__VA_ARGS__);printf("\n")
#define LOGE(...) printf(__VA_ARGS__);printf("\n")
#endif
#endif