$:.unshift('.')
$:.unshift('./lib')
$:.unshift('..')
$:.unshift('../lib')

require('test/unit')
require('roc')


class T < Test::Unit::TestCase

# simple usage
#

  def test_0010
    r = ROCarray.new( %w(P N P) )
    assert r.auc == 0.5
  end

end
