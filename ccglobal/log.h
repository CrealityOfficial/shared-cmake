#ifndef __CC_GLOBAL_LOG__
#define __CC_GLOBAL_LOG__

#if __ANDROID__
#include <android/log.h>

#define  LOGI(...)  __android_log_print(ANDROID_LOG_INFO,"NativeCC",__VA_ARGS__)
#define  LOGE(...)  __android_log_print(ANDROID_LOG_ERROR,"NativeCC",__VA_ARGS__)
#else
#define LOGI(...)
#define LOGE(...)
#endif
#endif