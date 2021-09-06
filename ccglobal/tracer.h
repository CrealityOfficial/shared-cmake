#ifndef TRACER_1630734954343_H
#define TRACER_1630734954343_H

namespace ccglobal
{
	class Tracer
	{
	public:
		virtual ~Tracer() {}
		virtual void progress(float r) = 0;
		virtual bool interrupt() = 0;

		virtual void message(const char* msg) = 0;
		virtual void failed(const char* msg) = 0;
		virtual void success() = 0;
	};
}
#endif // TRACER_1630734954343_H