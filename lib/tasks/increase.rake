
namespace :increase do
  task :update => :environment do

    require 'open-uri'
    require 'json'

    token = "1234567890qwertyuiopasdfghjklzxcvbnm"
    url = "https://increase-transactions.herokuapp.com"

    # force pass heroku 500 internal error
    begin
      puts "Getting #{url}/file.txt ..."
      @response = open("#{url}/file.txt", "Authorization" => "Bearer #{token}").read
    rescue
      sleep(10)
      retry
    end

    @payments = []
    @transactions = []
    @discounts = []

    @response.each_line do |f|
      puts f

      if f[0] == "1"
        # puts "header"
        # puts "Payment ID: #{f.slice(1...33)}"
        # puts "Coin: #{f.slice(36...39)}"
        # puts "Total amount: #{f.slice(39...52)}"
        # puts "Total discount: #{f.slice(52...65)}"
        # puts "Total with discounts: #{f.slice(65...78)}"

        @payment_attr =  {
          payment_id: "#{f.slice(1...33)}",
          coin: "#{f.slice(36...39)}",
          total_amount: "#{f.slice(39...52)}",
          total_discount: "#{f.slice(52...65)}",
          total_with_discounts: "#{f.slice(65...78)}"
        }

      end

      if f[0] == "2"
        # puts "transaction"
        # puts "ID: #{f.slice(1...33)}"
        # puts "Amount: #{f.slice(33...46)}"
        # puts "Kind: #{f[51]}"

        transaction = {
          transaction_id: "#{f.slice(1...33)}",
          amount: "#{f.slice(33...46)}",
          kind: "#{f[51]}"
        }

        @transactions << transaction

      end

      if f[0] == "3"
        # puts "discount"
        # puts "ID: #{f.slice(1...33)}"
        # puts "Amount: #{f.slice(33...46)}"
        # puts "Kind: #{f[49]}"

        discount = {
          discount_id: "#{f.slice(1...33)}",
          amount: "#{f.slice(33...46)}",
          kind: "#{f[49]}"
        }

        @discounts << discount

      end

      if f[0] == "4"
        # puts "footer"
        # puts "Date of pay: #{f.slice(16...24)}"
        # puts "Client ID: #{f.slice(24...56)}"
        client_id = f.slice(24...56)
        @payment_attr["payment_date"] = Date.parse(f.slice(16...24))

        # force pass heroku 500 internal error
        begin
          puts "Getting client ..."
          json = JSON.load(open("#{url}/clients/#{client_id}", "Authorization" => "Bearer #{token}"))
        rescue
          sleep(10)
          retry
        end

        unless json.nil?
          # puts json["id"]
          # puts json["email"]
          # puts json["first_name"]
          # puts json["last_name"]
          # puts json["job"]
          # puts json["country"]
          # puts json["address"]
          # puts json["zip_code"]
          # puts json["phone"]

          client = {
            client_id: client_id,
            email: json["email"],
            first_name: json["first_name"],
            last_name: json["last_name"],
            job: json["job"],
            country: json["country"],
            address: json["address"],
            zip_code: json["zip_code"],
            phone: json["phone"]
          }

          @client = Client.find_or_initialize_by(client_id: client["client_id"])
          @client.update!(client)

          unless @client.nil?
            @payment = @client.payments.find_or_initialize_by(payment_id: @payment_attr["payment_id"])
            @payment.update!(@payment_attr)

            @transactions.each do |transaction|
              @transaction = @payment.transactions.find_or_initialize_by(transaction_id: transaction["id"])
              @transaction.update!(transaction)
            end

            @discounts.each do |discount|
              @discount = @payment.discounts.find_or_initialize_by(discount_id: discount["id"])
              @discount.update!(discount)
            end

          end

        end

      end

    end

  end
end
