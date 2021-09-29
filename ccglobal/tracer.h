#ifndef TRACER_1630734954343_H
#define TRACER_1630734954343_H

#include <stdarg.h>
#include <stdio.h>

namespace ccglobal
{
	/*
	* ׷�ٹ��� ״̬�������
	* progress �ص����̽���
	* failed ���̳������ش��󣬹��̻���������ص��������������ԭ��
	* success ���̳ɹ�ִ���꣬��ص��������
	*/

	class Tracer
	{
	public:
		virtual ~Tracer() {}
		virtual void progress(float r) = 0;
		virtual bool interrupt() = 0;

		virtual void message(const char* msg) = 0;
		virtual void failed(const char* msg) = 0;
		virtual void success() = 0;

		void formatMessage(const char* format, ...)
		{
			char buf[1024] = { 0 };
			va_list args;
			va_start(args, format);
			vsprintf(buf, format, args);
			message(buf);
			va_end(args);
		}
	};
}
#endif // TRACER_1630734954343_H