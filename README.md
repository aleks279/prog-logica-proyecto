# Instituto Tecnologico de Costa Rica
# Escuela de Ing en Computacion
# Programacion Logica

Saul Zamora
200835773

### Descripcion
Programa en Prolog (SWI-Prolog) que encuentra transforma un grafo cualquiera en un grafo bipartito. Dado que la transformacion produce mas de un resultado, el programa retorna todos los resultados posubles

### Uso

#### Entradas
* N = lista con los nodos, ie [a,b,c]
* A = lista de listas con las aristas, ie [[a,b],[b,c],[a,c]]

#### "Salidas"
* U = subconjunto de N, ie [a,b]
* V = subconjunto de N, ie [c]
* B = aristas, ie [[c,b],[a,c]]

`mgb(N,A,U,V,B).`
