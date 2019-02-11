#!/usr/bin/env ruby
require 'savon'

username = ARGV[0]
password = ARGV[1]

wsdl_url = 'https://services.shoprunner.com/staging/services/order?wsdl'
client = Savon.client do
    wsdl wsdl_url
    log true
    log_level :debug
    wsse_auth(username, password, :digest)
    namespaces('xmlns:ns1' => 'http://www.shoprunner.com/schema/OrderWS')
    convert_request_keys_to :none
end

response = client.call(:order, message: {
    Partner: "TESTPARTNER",
    Order: [{
            OrderNumber: "TEST100",
            OrderDate: "2014-01-10T16:58:45",
            SRAuthenticationToken: "037t4ufg820r3ge87rgf9r3x",
            CurrencyCode: "USD",
            TotalNumberOfItems: 1,
            TotalNumberOfShopRunnerItems: 1,
            OrderTax: 0.0,
            OrderTotal: 205.68
          }]})

puts(response.body)
