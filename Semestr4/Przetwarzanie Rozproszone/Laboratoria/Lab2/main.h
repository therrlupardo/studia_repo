#pragma once
#include <stdbool.h>
#include <stdio.h>
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

int pop(struct list *lista);
int print(struct list* lista, bool backwards);
int push(struct list *lista, int value);
int insert(struct list* lista, int value, int position);
int remove2(struct list* lista, int position);
