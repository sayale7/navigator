require 'test_helper'

class MessageMailerTest < ActionMailer::TestCase
  test "recived" do
    @expected.subject = 'MessageMailer#recived'
    @expected.body    = read_fixture('recived')
    @expected.date    = Time.now

    assert_equal @expected.encoded, MessageMailer.create_recived(@expected.date).encoded
  end

end
