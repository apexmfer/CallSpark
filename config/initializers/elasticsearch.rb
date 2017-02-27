require 'elasticsearch/model'

Elasticsearch::Model.client = Elasticsearch::Client.new url: '127.0.0.1:9200', log: true
