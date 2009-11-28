$:.unshift('.')
$:.unshift('./lib')
$:.unshift('..')
$:.unshift('../lib')

require('test/unit')
require('roc')


class T < Test::Unit::TestCase

  # simple usage
  def test_0010
    r = ROCarray.new %w(P N P) 
    assert r.auc == 0.5
  end

  # without positive samples, it should be nil
  def test_0020
    r = ROCarray.new %w(NN)
    assert r.auc == nil
  end

  # without negative samples, it should be nil
  def test_0025
    r = ROCarray.new %w(PP)
    assert r.auc == nil
  end

  # only equal predictions -> 0.5
  def test_0030
    r = ROCarray.new %w(PPPPPPPPPPNNNNNNNNNN)
    d = 1e-12
    assert r.auc>0.5-d and r.auc<0.5+d
  end
  
  # initialization with prediction values
  def test_0040
    assert ROCarray.new([1.0 , 2.0 , 3.0],[0]).auc==0.0 and
           ROCarray.new([1.0 , 2.0 , 3.0],[1]).auc==0.5 and
           ROCarray.new([1.0 , 2.0 , 3.0],[2]).auc==1.0 
  end

end
