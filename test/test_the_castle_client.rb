require 'helper'

class TestTheCastleClient < Test::Unit::TestCase

  def setup 
    TheCastleClient.key     = 'key'
    TheCastleClient.secret  = 'secret'
    TheCastleClient.host    = "development.prx.org"
    TheCastleClient.port    = 3001
    TheCastleClient.version = 'v1'
  end

  def test_test_fixer
    response = TheCastleClient.test_fixer
    puts response.read_body
  end

  def test_account_data
    response = TheCastleClient.account_data(7018, {:scale=>'week', :start_on=>'2010-01-01', :end_on=>'2010-04-01'})
    puts response.read_body
  end
  
  def test_account_aggregates
    response = TheCastleClient.account_aggregates(7018)
    puts response.read_body
  end
  
  def test_piece_aggregates
    response = TheCastleClient.piece_aggregates(37745)
    puts response.read_body
  end
  
  def test_popular_pieces
    response = TheCastleClient.popular_pieces(Date.parse('2011-01-03'), 10)
    puts response.read_body
  end
  
end
