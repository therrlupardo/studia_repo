#include "main.h"
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
			scanf("%d", &value1);
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
			if(remove2(lista, value1) == 0)
			{
				printf("Operacja nieudana!\n");
			}
		}
		else if(strcmp(command, "help") == 0)
		{
			printf("Lista dostepnych komend:\npush x - umieszcza wartosc x na koncu listy\npop - usuwa ostatni element listy\nprint true - wypisuje kolejne elementy listy\nprint false - wypisuje elementy listy od konca\ninsert x n - umieszcza wartosc x na n-tym miejscu listy(liczac od 0)\nremove n - usuwa n-ty element listy (liczac od 0)\nkoniec - zamyka program\n");
		}
	//	print(lista, true);
	} while (strcmp(command,"koniec")!=0);
	free(lista);
	free(command);
	return 0;
}
