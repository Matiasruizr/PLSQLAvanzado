/*
1. Cuál es el producto más vendido, esto considera cual es el producto que más cantidad ha vendido en los detalles. 
2. Cuál es el producto que más se repite en los detalles, independiente de la cantidad indicada en ellos.
3. Cuál es el producto más caro vendido.
4. Cuáles son los productos menos vendidos.
5. Cuál es la sucursal que más ventas registra, eso es de acuerdo a la que más compras han realizado de acuerdo a sus clientes.
6. Cuál es la sucursal que menos ventas registra, esto es de acuerdo a la que menos compras han realizado de acuerdo a sus clientes.
7. Cuál es la sucursal que más clientes tiene registrados. 
8. Cuál es la sucursal que menos clientes tiene registrados.
9. Cuál es el producto vendido más caro. 
10. Cuál es el cliente que más compras ha realizado y cuál es el producto que más ha comprado.
11. Cuál es el cliente que menos compras ha realizado (que efectivamente hubiera comprado algo) y cuál es el producto más barato que compró.
12. Cuales con los clientes que no han realizado ninguna compra, debe mostrar todos los datos del cliente. 
13. Cuáles son los productos que no se han vendido, debe mostrar todos los datos del producto.
14. Cuál es el producto que más se ha vendido en cada sucursal, si hay más de un producto debe mostrar solo uno.
15. Cuál es la marca que más veces ha sido registrada en una venta. 
16. Cual o cuales marcas no han vendido ningún producto (en caso de que no hubiera marcas sin ventas debe indicar “No existen marcas sin ventas”). 
*/


/* 1 */
select * from
(select sum(df.cantidad) as max_venta,  p.CODIGO_PROD
from producto p 
join detalle_factura df on p.CODIGO_PROD = df.CODIGO_PROD
group by p.codigo_prod 
order by max_venta desc)
where ROWNUM = 1;

/* 2 */
select * from(
select  p.CODIGO_PROD, count(df.NUM_FACTURA) as mas_repetido
from producto p 
join detalle_factura df on p.CODIGO_PROD = df.CODIGO_PROD
group by p.codigo_prod 
order by mas_repetido desc)
where rownum = 1;

/* 3 */
select * from(
select  p.CODIGO_PROD, p.PRECIO, df.NUM_FACTURA
from producto p 
join detalle_factura df on p.CODIGO_PROD = df.CODIGO_PROD
order by p.precio desc)
where rownum = 1;
