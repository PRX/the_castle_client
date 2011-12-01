require 'helper'

class TestTheCastleClient < Test::Unit::TestCase
  
  def setup 
    TheCastleClient.key     = '9NmQzsWBWs8TyfJswqMmkmjwAH3ItNBIC72KLjQK'
    TheCastleClient.secret  = '592BSoaCb4FfwqsZ6Ql8WShVZ6HVnecR4Dk9lRfQ'
    TheCastleClient.host    = "development.prx.org"
    TheCastleClient.port    = 3000
    TheCastleClient.version = 'v1'
  end
  
  def test_account_data
    response = TheCastleClient.account_data(7018, {:scale=>'week', :start_on=>'2010-01-01', :end_on=>'2010-04-01'})
    puts response.read_body
  end
  
  def test_account_embedders
    response = TheCastleClient.query(128129, 'account', 'embedders', {:scale=>'week', :start_on=>'2011-10-24', :end_on=>'2011-11-02'})
    puts response.read_body
  end
  
  def test_account_referrers
    response = TheCastleClient.query(128129, 'account', 'referrers', {:scale=>'week', :start_on=>'2011-10-24', :end_on=>'2011-11-02'})
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
  
  def test_piece_data
    response = TheCastleClient.piece_data(37745, {:scale=>'week', :start_on=>'2010-01-01', :end_on=>'2010-04-01'})
    puts response.read_body
  end
  
  def test_popular_pieces
    response = TheCastleClient.popular_pieces(Date.parse('2011-01-03'), 10)
    puts response.read_body
  end
  
end
