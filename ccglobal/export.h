#ifndef EXPORT_INTERFACE_1604911737496_H
#define EXPORT_INTERFACE_1604911737496_H

#ifdef WIN32
	#define CC_DECLARE_EXPORT __declspec(dllexport)
	#define CC_DECLARE_IMPORT __declspec(dllimport)
#else
	#define CC_DECLARE_EXPORT __attribute__((visibility("default")))
	#define CC_DECLARE_IMPORT
#endif
#endif // EXPORT_INTERFACE_1604911737496_H