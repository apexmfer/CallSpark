require 'elasticsearch/model'


p 'Starting Elasticsearch on Port 9200'
Elasticsearch::Model.client = Elasticsearch::Client.new url: '127.0.0.1:9200', log: true
