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

/* 4 */
select * from(
select sum(df.cantidad) as min_venta,  p.CODIGO_PROD
from producto p 
join detalle_factura df on p.CODIGO_PROD = df.CODIGO_PROD
group by p.codigo_prod 
order by min_venta asc)
where rownum = 1;

/* 5. Cuál es la sucursal que más ventas registra, eso es de acuerdo a la que más compras han realizado de acuerdo a sus clientes. */
select * from
(select sum(df.CANTIDAD) as ventas,s.NOMBRE from cliente c 
join factura f on c.RUT = f.RUT_CLIENTE
join DETALLE_FACTURA df on df.NUM_FACTURA = f.NUM_FACTURA
join PRODUCTO p on df.CODIGO_PROD = p.CODIGO_PROD
join SUCURSAL s on c.CODIGO_SUC = s.CODIGO_SUC
group by s.NOMBRE order by ventas desc)
where rownum = 1;



/* 6 */
select * from
(select sum(df.CANTIDAD) as ventas,s.NOMBRE from cliente c 
join factura f on c.RUT = f.RUT_CLIENTE
join DETALLE_FACTURA df on df.NUM_FACTURA = f.NUM_FACTURA
join PRODUCTO p on df.CODIGO_PROD = p.CODIGO_PROD
join SUCURSAL s on c.CODIGO_SUC = s.CODIGO_SUC
group by s.NOMBRE order by ventas asc)
where rownum = 1;

/* 7. Cuál es la sucursal que más clientes tiene registrados.  */
select * from(
select count(c.RUT) as clientes, s.NOMBRE from SUCURSAL s 
join CLIENTE c on s.CODIGO_SUC = c.CODIGO_SUC
group by s.nombre
order by clientes desc)
where rownum = 1;

/* 8. Cuál es la sucursal que menos clientes tiene registrados. */
select * from(
select count(c.RUT) as clientes, s.NOMBRE from SUCURSAL s 
join CLIENTE c on s.CODIGO_SUC = c.CODIGO_SUC
group by s.nombre
order by clientes asc)
where rownum = 1;

/* 9. Cuál es el producto vendido más caro. */
select * from(
select p.descripcion, p.precio from PRODUCTO p 
join DETALLE_FACTURA df on p.CODIGO_PROD = df.CODIGO_PROD
join FACTURA f on df.NUM_FACTURA = f.NUM_FACTURA
where df.CANTIDAD > 0
order by precio desc)
where rownum = 1;

/* 10 */
select * from(
select cl.rut, count(f.NUM_FACTURA) as compras from cliente cl
join factura f on cl.rut = f.rut_cliente
group by cl.rut
order by compras desc)
where rownum = 1;

/* 11 - . Cuál es el cliente que menos compras ha realizado (que efectivamente hubiera comprado algo) y cuál es el producto más barato que compró. */
select cl.rut, count(f.NUM_FACTURA), p.DESCRIPCION as compras from cliente cl
join factura f on cl.rut = f.rut_cliente
join DETALLE_FACTURA df on f.NUM_FACTURA = df.NUM_FACTURA
join PRODUCTO p on df.CODIGO_PROD = p.CODIGO_PROD
group by cl.rut, p.DESCRIPCION
order by compras asc;
