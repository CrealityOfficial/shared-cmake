#ifndef __CC_GLOBAL_SHINY__
#define __CC_GLOBAL_SHINY__

#if CC_USE_SHINY
#include "ShinyMacros.h"
#else
#include <string>
#define PROFILE_UPDATE()
#define PROFILE_SET_DAMPING(x)
#define PROFILE_GET_DAMPING()			0.0f
#define PROFILE_OUTPUT(x)
#define PROFILE_OUTPUT_STREAM(x)
#define PROFILE_CLEAR()
#define PROFILE_GET_TREE_STRING()		std::string()
#define PROFILE_GET_FLAT_STRING()		std::string()
#define PROFILE_DESTROY()
#define PROFILE_BEGIN(name)
#define PROFILE_BLOCK(name)
#define PROFILE_FUNC()
#define PROFILE_CODE(code)				do { code; } while (0)
#define PROFILE_SHARED_GLOBAL(name)
#define PROFILE_SHARED_MEMBER(name)
#define PROFILE_SHARED_DEFINE(name)
#define PROFILE_SHARED_BEGIN(name)
#define PROFILE_SHARED_BLOCK(name)
#define PROFILE_GET_SHARED_DATA(name)	ShinyGetEmptyData()
#define PROFILE_GET_ROOT_DATA()			ShinyGetEmptyData()
#endif

#endif // __CC_GLOBAL_SHINY__