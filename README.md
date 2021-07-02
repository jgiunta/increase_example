# increase_example

docker-compose run --no-deps web rails new . --force --database=sqlite3
docker-compose build
docker-compose up

MVC creados utilizando Scaffold.

Se generaron 4 modelo. Clientes, pagos, transacciones y descuentos. Las transacciones y los descuentos pertenecen a un pago, mientras que los pagos pertenecen a un cliente.

rails g scaffold client client_id:string email first_name last_name job country address zip_code phone
rails g scaffold payment payment_id:string coin:integer total_amount:integer total_discount:integer total_with_discounts:integer payment_date:date client:belongs_to
rails g scaffold transactions transaction_id:string amount:integer kind:integer payment:belongs_to
rails g scaffold discount discount_id:string amount:integer kind:integer payment:belongs_to

Las rutas para la API solicitada se configuraron de la siguiente manera:

GET  /clients/:id(.:format)              clients#show {:format=>:json}
GET  /clients/:id/payments(.:format)     clients#payments {:format=>:json}
GET  /clients/:id/transactions(.:format) clients#transactions {:format=>:json}

Todo bajo un mismo controllador llamado clients el cual contiene 3 métodos para cumplir con las pautas.

Crawler externo

El crawler externo es un task que absorve los datos de la URL indicada y parsea deslizando las posiciones de cada linea para poder diferenciar cada uno de los datos.

bundle exec rake increase:update
