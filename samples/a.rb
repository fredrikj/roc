# A simple example of roc
#
  require 'roc'

  r1 = ROCarray.new( %w(P N P) )
  r2 = ROCarray.new( [0.3, 0.5, 0.7], [0, 2] )
  r1.roc
  r1.auc
  r1.auc(0.1)
