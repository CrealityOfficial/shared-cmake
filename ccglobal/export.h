#ifndef EXPORT_INTERFACE_1604911737496_H
#define EXPORT_INTERFACE_1604911737496_H

#ifdef WIN32
	#if CC_FORCE_EXPORT_STATIC
		#define CC_DECLARE_EXPORT 
		#define CC_DECLARE_IMPORT
	#elif CC_FORCE_IMPORT_STATIC
		#define CC_DECLARE_EXPORT __declspec(dllexport) 
		#define CC_DECLARE_IMPORT
	#else
		#define CC_DECLARE_EXPORT __declspec(dllexport)
		#define CC_DECLARE_IMPORT __declspec(dllimport)
	#endif
#else
	#define CC_DECLARE_EXPORT __attribute__((visibility("default")))
	#define CC_DECLARE_IMPORT
#endif

#endif // EXPORT_INTERFACE_1604911737496_H