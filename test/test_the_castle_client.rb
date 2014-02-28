require 'helper'
require 'active_support/all'

class TestTheCastleClient < Test::Unit::TestCase
  
  def setup 
    TheCastleClient.key     = ENV['CASTLE_KEY']
    TheCastleClient.secret  = ENV['CASTLE_SECRET']
    TheCastleClient.host    = ENV['CASTLE_HOST']    || 'thecastle.dev'
    TheCastleClient.port    = ENV['CASTLE_PORT']    || 80
    TheCastleClient.version = ENV['CASTLE_VERSION'] || 'v1'

    @end_on = Date.today
    @start_on = @end_on - 3.months

    @account_id = 3437
    @piece_id = 73865
  end

  def test_account_data
    response = TheCastleClient.account_data(@account_id, {:scale=>'week', :start_on=>@start_on, :end_on=>@end_on})
    puts response.read_body
  end
  
  def test_account_embedders
    response = TheCastleClient.query(@account_id, 'account', 'embedders', {:scale=>'week', :start_on=>@start_on, :end_on=>@end_on})
    puts response.read_body
  end

  def test_account_aggregates
    response = TheCastleClient.account_aggregates(@account_id)
    puts response.read_body
  end
  
  def test_piece_aggregates
    response = TheCastleClient.piece_aggregates(@piece_id)
    puts response.read_body
  end
  
  def test_piece_data
    @end_on = Date.today
    @start_on = @end_on - 3.months
    response = TheCastleClient.piece_data(@piece_id, {:scale=>'week', :start_on=>@start_on, :end_on=>@end_on})
    puts response.read_body
  end
  
  def test_popular_pieces
    response = TheCastleClient.popular_pieces(@start_on, 10)
    puts response.read_body
  end
  
  def test_most_listened_pieces
    response = TheCastleClient.most_listened_pieces(@start_on, 10)
    puts response.read_body
  end

  # this cube is not deployed to production yet
  # def test_account_referrers
  #   response = TheCastleClient.query(128129, 'account', 'referrers', {:scale=>'week', :start_on=>'2011-10-24', :end_on=>'2011-11-02'})
  #   puts response.read_body
  # end

end
