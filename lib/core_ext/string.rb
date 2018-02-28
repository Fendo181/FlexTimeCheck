class String
  def unistrip
    gsub(/\A[[:space:]]+|[[:space:]]+\z/,'')
  end

  def parse_duration
    self =~ /\A(\d+):(\d+)\z/ ? $1.to_i * 60 + $2.to_i : self
  end
end
