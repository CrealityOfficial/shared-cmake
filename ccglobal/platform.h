#ifndef __CCGLOBAL_PLATFORM_H
#define __CCGLOBAL_PLATFORM_H

#include <stdio.h>
#include <cmath>

#if CC_SYSTEM_WIN
#include <io.h>
#else
#include <unistd.h>
#endif
#define _cc_access access

#if CC_SYSTEM_WIN
	#define _cc_ftelli64 _ftelli64
#else
	#ifdef __USE_FILE_OFFSET64
		#define _cc_ftelli64 ftello64
	#else
		#define _cc_ftelli64 ftell
	#endif
#endif

#endif // __CCGLOBAL_PLATFORM_H
