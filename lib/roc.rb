#----------
# ROCarray
#----------
# An Array consisting only
# of 'P' and 'N' (for true positive and negative).
# It is further assumed that self is an array of
# predictions ordered such that most positive predictions
# come first.
# Finally - if some elements have been ranked equally, they
# should appear together in the same element in the Array.
class ROCarray < Array
  # Two ways to initialize:
  #
  # 1) arg1 is prediction values
  #    arg2 is indices of P elements in arg1
  #
  # 2) arg1 is an array of T and P: 
  #    Example: %w(P PN P N N) 
  #
  def initialize(arg1,arg2=nil)
    a = if arg2
          pn = Array.new(arg1.size,'N')
          arg2.each{|arg2i| pn[arg2i]='P'}
          tmp = arg1.zip(pn).sort_by{|i,j| -i}
          i=1
          while tmp[i]
            if tmp[i][0]==tmp[i-1][0]
              tmp[i-1][1] += tmp[i][1]
              tmp.delete_at i
            else
              i+=1
            end
          end
          tmp.map{|i,j| j}
        else
          if arg1.find{|i| !i.is_a? String or i.upcase !~ /^[PN]+$/}
            raise 'Incorrect Array for ROC' 
          end
          arg1.dup
        end
    a.map!{|i| i.upcase}
    super(a)
  end

  # --- roc ---
  # Returns an array of x and y values up until fpmax.
  # Returns nil if there are no P values
  def roc(fpmax=1)
    ptot = self.join.count('P')
    return nil if ptot==0
    ntot = self.join.count('N')
    ystep = 1.0 / ptot
    xstep = 1.0 / ntot
    parr = self.inject([[0,0]]) do |points,rocpoint|
             break points if points.last[0]>=fpmax
             curpoint = points.last.dup
             rocpoint.split('').each do |char|
               case char
               when 'N' : curpoint[0]+=xstep
               when 'P' : curpoint[1]+=ystep
               end
             end
             points << curpoint
           end
    # Remove what is greater than fpmax
    if parr.last[0]>fpmax
      k = (parr[-1][1]-parr[-2][1]) / (parr[-1][0]-parr[-2][0])
      r = fpmax - parr[-2][0]
      parr[-1] = [ fpmax, parr[-2][1] + k * r ]
    end
    parr
  end

  # --- auc ---
  def auc(fpmax=1)
    r = self.roc(fpmax)
    return nil unless r
    (1...r.size).inject(0) do |area,i|
      length =  [ r[i][0] - r[i-1][0], r[i][1] - r[i-1][1] ]
      area += length[0] * ( r[i-1][1] + 0.5*length[1] )
    end
  end
end
