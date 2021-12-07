#ifndef _CONTAINER_1638848103128_H
#define _CONTAINER_1638848103128_H
#include "ccglobal/log.h"
#include <list>

#define LIST_ADD(container, x) \
		{ \
			auto it = std::find(container.begin(), container.end(), x); \
			if(it != container.end() || !x) \
				LOGE("LIST_ADD dumplicate element or empty element."); \
			else \
				container.push_front(x); \
		}

#define LIST_ADD_BACK(container, x) \
		{ \
			auto it = std::find(container.begin(), container.end(), x); \
			if(it != container.end() || !x) \
				LOGE("LIST_ADD dumplicate element or empty element."); \
			else \
				container.push_back(x); \
		}

#define LIST_REMOVE(container, x) \
		{ \
			auto it = std::find(container.begin(), container.end(), x); \
			if(it == container.end() || !x) \
				LOGE("LIST_REMOVE try remove no exist element."); \
			else \
				container.erase(it); \
		}

template<class T>
class LContainer
{
public:
	typedef typename std::list<T*>::iterator LIterator;
public:
	LContainer() {}
	~LContainer() {}

	void addElement(T* element)
	{
		if (!element)
			return;

		LIterator it = std::find(m_elements.begin(), m_elements.end(), element);
		if (it != m_elements.end())
			return;

		m_elements.push_back(element);
	}

	void removeElement(T* element)
	{
		if (!element)
			return;

		LIterator it = std::find(m_elements.begin(), m_elements.end(), element);
		if (it == m_elements.end())
			return;

		m_elements.erase(it);
	}

	template<class Callback>
	void notify(Callback c)
	{
		for (LIterator it = m_elements.begin(); it != m_elements.end(); ++it)
			c(*it);
	}

protected:
	std::list<T*> m_elements;
};

#endif // _CONTAINER_1638848103128_H