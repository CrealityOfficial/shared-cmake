#ifndef __CCGLOBAL_PLATFORM_H
#define __CCGLOBAL_PLATFORM_H

#include <stdio.h>

#if CC_SYSTEM_WIN
#include <io.h>
#define _cc_access access

#elif CC_SYSTEM_ANDROID
#include <unistd.h>
#define _cc_access access

#elif CC_SYSTEM_LINUX
#include <unistd.h>
#define _cc_access access

#elif CC_SYSTEM_MAC || CC_SYSTEM_IOS
#include <unistd.h>
#define _cc_access access

#else
#include <unistd.h>
#define _cc_access access
#endif

#endif // __CCGLOBAL_PLATFORM_H
