#include "main.h"
int insert(struct list* lista, int value, int position)
{
	struct node* it, * tmp;
	if (lista->head == NULL) {
		if (position != 0) return 0;
		push(lista, value);
		return 1;
	}
	it = lista->head;
	tmp = malloc(sizeof(struct node));
	if(position == 0)
	{
		tmp->value = value;
		tmp->next = lista->head;
		tmp->prev = lista->tail;
		lista->tail->next = tmp;
		lista->head->prev = tmp;
		lista->head = tmp;
		return 1;
	}
	int counter = 0;
	for(int i = 0; i < position; i++)
	{
		it = it->next;
		if(it == lista->head)
		{
			if(i == position-1){
				push(lista, value);
				return 1;
			}
			return 0;
		}
	}
	tmp->value = value;
	tmp->next = it;
	tmp->prev = it->prev;
	it->prev->next = tmp;
	it->prev = tmp;

	return 1;
}

int remove2(struct list* lista, int position)
{
	if (lista->head == NULL) return 0;
	if(position == 0)
	{
		if(lista->head->next == lista->head)
		{
			pop(lista);
			return 1;
		}
		free(lista->head);
		lista->tail->next = lista->head->next;
		lista->head->next->prev = lista->tail;
		lista->head = lista->head->next;
		return 1;
	}
	else
	{
		struct node* it;
		it = lista->head;
		for(int i = 0; i < position; i++)
		{
			it = it->next;
			if (it == lista->head)	return 0;
		}
		it->prev->next = it->next;
		it->next->prev = it->prev;
		if(it == lista->tail)
		{
			lista->tail = lista->tail->prev;
		}
		free(it);
		return 1;
	}
}

