require 'oauth'
require 'json'
require 'cgi'

module TheCastleClient
  class << self
    
    attr_accessor :key, :secret, :scheme, :host, :port, :version

    def account_data(account_id, options={})
      url = "/api/#{version}/accounts/#{account_id}#{to_query(options)}"
      get(url, {'Accept'=>'application/json', 'Content-Type'=>'application/json'})
    end

    def account_aggregates(account_id)
      url = "/api/#{version}/accounts/#{account_id}/aggregates"
      get(url, {'Accept'=>'application/json', 'Content-Type'=>'application/json'})
    end

    def piece_aggregates(piece_id)
      url = "/api/#{version}/pieces/#{piece_id}/aggregates"
      get(url, {'Accept'=>'application/json', 'Content-Type'=>'application/json'})
    end

    def popular_pieces(popular_on=Date.today, limit=25)
      popular_on = Date.parse(popular_on) if popular_on.is_a?(String)
      popular_on_s = popular_on.to_s
      options = {'popular_on'=>popular_on_s, 'limit'=>limit}
      url = "/api/#{version}/pieces/popular#{to_query(options)}"
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
