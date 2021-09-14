#ifndef TRACER_1630734954343_H
#define TRACER_1630734954343_H

namespace ccglobal
{
	/*
	* 追踪过程 状态的虚基类
	* progress 回调过程进度
	* failed 过程出现严重错误，过程会结束，并回调这个函数，报告原因
	* success 过程成功执行完，会回调这个函数
	*/

	class Tracer
	{
	public:
		virtual ~Tracer() {}
		virtual void progress(float r) = 0;
		virtual bool interrupt() = 0;

		virtual void message(const char* msg,const char* fileName=nullptr,int line=0) = 0;
		virtual void failed(const char* msg, const char* fileName = nullptr, int line = 0) = 0;
		virtual void success() = 0;
	};
}
#endif // TRACER_1630734954343_H