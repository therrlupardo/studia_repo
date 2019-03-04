#include "main.h"
int push(struct list *lista, int value)
{
	struct node* tmp, *head, *tail;

	tmp = malloc(sizeof(struct node));

	if(lista->head == NULL)
	{
		tmp = malloc(sizeof(struct node));
		tmp->value = value;
		tmp->prev = tmp;
		tmp->next = tmp;
		lista->head = tmp;
		lista->tail = tmp;
	}
	else
	{
		head = lista->head;
		tail = lista->tail;

		tmp->value = value;
		tmp->prev = tail;
		tmp->next = head;
		
		head->prev = tmp;
		tail->next = tmp;
		lista->tail = tmp;
	}
	return 1;
}

int pop(struct list *lista)
{
	if (lista->head == NULL) { return 0; }
	if(lista->head == lista->tail)
	{
		free(lista->head);
		lista->head = NULL;
		lista->tail= NULL;
		return 1;
	}
	if(lista->head->next == lista->tail)
	{
		free(lista->tail);
		lista->head->next = lista->head;
		lista->head->prev = lista->head;
		lista->tail = lista->head;
		return 1;
	}
	else
	{
		free(lista->tail);
		lista->head->prev = lista->tail->prev;
		lista->tail = lista->tail->prev;
		lista->tail->next = lista->head;
		return 1;
	}
}

int print(struct list* lista, bool backwards)
{
	printf("Czesc\n");
	if(lista->head == NULL)
	{
		printf("Lista jest pusta!\n");
		return 0;
	}
	struct node* it;
	if(backwards == false)
	{
		it = lista->tail;
		do
		{
			printf("%d ", it->value);
			it = it->prev;
		} while (it != lista->tail);
		printf("\n");
	}
	else
	{
		it = lista->head;
		do
		{
			printf("%d ", it->value);
			it = it->next;
		} while (it != lista->head);
		printf("\n");
	}
	return 1;
}

