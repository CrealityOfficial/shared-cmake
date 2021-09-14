#ifndef TRACER_1630734954343_H
#define TRACER_1630734954343_H

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

		virtual void message(const char* msg,const char* fileName=nullptr,int line=0) = 0;
		virtual void failed(const char* msg, const char* fileName = nullptr, int line = 0) = 0;
		virtual void success() = 0;
	};
}
#endif // TRACER_1630734954343_H