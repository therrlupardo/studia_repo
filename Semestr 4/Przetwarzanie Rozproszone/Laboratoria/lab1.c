#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

struct node
{
	int value;
	struct node *next;
	struct node *prev;
};

struct list
{
	struct node* head;
	struct node* tail;
};

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
		lista->head = NULL;
		lista->tail= NULL;
		return 1;
	}
	if(lista->head->next == lista->tail)
	{
		lista->head->next = lista->head;
		lista->head->prev = lista->head;
		lista->tail = lista->head;
		return 1;
	}
	else
	{
		lista->head->prev = lista->tail->prev;
		lista->tail = lista->tail->prev;
		lista->tail->next = lista->head;
		return 1;
	}
}

int print(struct list* lista, bool backwards)
{
	if(lista->head == NULL)
	{
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

int insert(struct list* lista, int value, int position)
{
	struct node* it, * tmp;
	if (lista->head == NULL) return 0;
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

int remove(struct list* lista, int position)
{
	if (lista->head == NULL) return 0;
	if(position == 0)
	{
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
			if (it == lista->head) return 0;
		}
		it->prev->next = it->next;
		it->next->prev = it->prev;
		return 1;
	}
}

int main()
{
	struct list* lista;
	lista = malloc(sizeof(struct list));
	lista->head = NULL;
	lista->tail = NULL;

	char* command = malloc(sizeof(char)*255);
	int value1, value2;

	push(lista, 1);
	pop(lista);

	do
	{
		scanf("%s", command);
		if(strcmp(command, "push") == 0)
		{
			scanf_s("%d", &value1);
			push(lista, value1);
		}
		else if (strcmp(command,"pop") == 0)
		{
			if(pop(lista) == 0)
			{
				printf("Operacja nieudana!\n");
			}
		}
		else if (strcmp(command, "print") == 0)
		{
			scanf("%s", command);
			if (strcmp(command, "true") == 0)
			{
				print(lista, true);
			}
			else if (strcmp(command, "false") == 0)
			{
				print(lista, false);
			}
			else printf("Nieznana komenda!\n");
		}
		else if (strcmp(command, "insert") == 0)
		{
			scanf("%d", &value1);
			scanf("%d", &value2);
			if(insert(lista, value1, value2) == 0)
			{
				printf("Operacja nieudana!\n");
			}
		}
		else if (strcmp(command, "remove") == 0)
		{
			scanf("%d", &value1);
			if(remove(lista, value1) == 0)
			{
				printf("Operacja nieudana!\n");
			}
		}
	//	print(lista, true);
	} while (strcmp(command,"koniec")!=0);

	return 0;
}