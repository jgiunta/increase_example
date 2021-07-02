# increase_example

# Docker, Rails y MySQL

El sistema fue desarrollado para que corra en Docker, con docker-compose y docker-sync para sincronizar los archivos en MacOS. La base del Dockerfile está basada en ruby y se utilizó MySQL como DB.

Para generar la app se ejecutaron los siguientes comandos:

- docker-compose run --no-deps web rails new . --force --database=mysql (se podría haber utilizado --api para solo generar los MVC necesarios)

- docker-compose build

- docker-compose up (éste último sirve para ejecutar la app)

# Modelos, Vistas y Controladores

MVC creados utilizando Scaffold.

Se generaron 4 modelos. Clientes, pagos, transacciones y descuentos. Las transacciones y los descuentos pertenecen a un pago, mientras que los pagos pertenecen a un cliente.

rails g scaffold client client_id:string email first_name last_name job country address zip_code phone

rails g scaffold payment payment_id:string coin:integer total_amount:integer total_discount:integer total_with_discounts:integer payment_date:date client:belongs_to

rails g scaffold transactions transaction_id:string amount:integer kind:integer payment:belongs_to

rails g scaffold discount discount_id:string amount:integer kind:integer payment:belongs_to

# Acceso a la API

Las rutas para la API solicitada se configuraron de la siguiente manera:

- Información de los clientes:

GET  /clients/:id(.:format)              clients#show {:format=>:json}

- Dinero que los clientes cobraron y el dinero que van a cobrar

GET  /clients/:id/payments(.:format)     clients#payments {:format=>:json}

- Transacciones de los clientes

GET  /clients/:id/transactions(.:format) clients#transactions {:format=>:json}

Todo bajo un mismo controllador llamado "clients", el cual contiene 3 métodos para cumplir con las pautas.

# Crawler

El crawler es un task que absorve los datos de la URL indicada y parsea deslizando las posiciones de cada linea para poder diferenciar cada uno de los datos. Luego genera los Hashes necesarios para ser impactados en los modelos. Los datos son actualizados por lo que si el script se ejecuta 3 veces en 10 minutos no generaría ningún registro incorrecto.

# Cron

Ésta task se ejecuta con cron cada 5 minutos para cumplir el requisito de la actualización de datos cada 10 minutos.

*/5 * * * * cd /app ; bundle exec rake increase:update

# Mejoras y optimizaciones

- Inicialmente se podría proteger la API con un TOKEN OAUTH para mayor seguridad en el acceso
- El crawler podría en vez de correr con cron y rake, hacerlo con un worker en sidekiq controlado por redis.
- Debería implementarse un cache para las respuestas de la API utilizando memcached
- De acuerdo al tráfico podría implementarse una réplica de la DB para enviar las consultas de lectura al slave y las escrituras al master.
- Las rutas las re estructuraría, ubicando las transacciones y descuentos detras del pago que corresponda. Por ejemplo /client/:client_id/payments/:payment_id/transactions y /client/:client_id/payments/:payment_id/discounts

# Ejemplos de acceso a la API

http://localhost:3000/clients/3d12c732821341ecb0c2ccf9606ae298/
http://localhost:3000/clients/3d12c732821341ecb0c2ccf9606ae298/payments
http://localhost:3000/clients/3d12c732821341ecb0c2ccf9606ae298/transactions

