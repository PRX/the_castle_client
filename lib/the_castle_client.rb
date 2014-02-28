require 'oauth'
require 'json'
require 'cgi'

module TheCastleClient
  class << self

    attr_accessor :key, :secret, :scheme, :host, :port, :version

    def most_listened_pieces(most_on=Date.today, limit=25)
      most_on = Date.parse(most_on) if most_on.is_a?(String)
      options = {'most_on'=>most_on.to_s, 'limit'=>limit}
      url = "/api/#{version}/pieces/most_listened#{to_query(options)}"
      get(url, {'Accept'=>'application/json', 'Content-Type'=>'application/json'})
    end

    def popular_pieces(popular_on=Date.today, limit=25)
      popular_on = Date.parse(popular_on) if popular_on.is_a?(String)
      popular_on_s = popular_on.to_s
      options = {'popular_on'=>popular_on_s, 'limit'=>limit}
      url = "/api/#{version}/pieces/popular#{to_query(options)}"
      get(url, {'Accept'=>'application/json', 'Content-Type'=>'application/json'})
    end

    #  these are just niceties around the query method; deprecate?
    def account_data(id, opts={}); query(id, 'account', nil, opts); end
    def account_aggregates(id); query(id, 'account', 'aggregates'); end
    def piece_data(id, opts={}); query(id, 'piece', nil, opts); end
    def piece_aggregates(id); query(id, 'piece', 'aggregates'); end

    def query(id, model='account', data_type=nil, options={})
      raise "Invalid data type #{data_type}" unless ['aggregates', 'referrers', 'embedders', '', nil].include?(data_type)
      url = ['/api', version, model.pluralize, id, data_type].compact.join("/") + to_query(options)
      get(url, {'Accept'=>'application/json', 'Content-Type'=>'application/json'})
    end

    protected

    [:delete, :get, :head, :post, :put, :request].each do |method|
      define_method method do |*args|
        access_token.send(method, *args)
      end
    end

    def consumer
      @consumer ||= OAuth::Consumer.new(key,
                                        secret,
                                        :site               => "#{scheme || 'http'}://#{host}:#{port}",
                                        :http_method        => :get)
    end

    def access_token
      @access_token ||= OAuth::AccessToken.new(consumer)
    end
    
    def to_query(hash)
      params = ''
      stack = []

      hash.each do |k, v|
        if v.is_a?(Hash)
          stack << [k,v]
        else
          params << "#{k}=#{v}&"
        end
      end

      stack.each do |parent, h|
        h.each do |k, v|
          if v.is_a?(Hash)
            stack << ["#{parent}[#{k}]", v]
          else
            params << "#{parent}[#{k}]=#{v}&"
          end
        end
      end

      params.chop! # trailing &
      (params.nil? || params.size <=0) ? '' : "?#{params}"
    end
    

  end
  
end
