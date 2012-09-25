class Unit
  UNITS = [
    {imperial: "%", metric: "%", imperials_per_metric: 1},
    {imperial: "Ha", metric: "Ha", imperials_per_metric: 1},
    {imperial: "psi", metric: "MPa", imperials_per_metric: 145.037738},
    {imperial: "lbs/ft3", metric: "kg/m3", imperials_per_metric: 0.0624},
    {imperial: "F", metric: "C", imperials_per_metric: 0}, # 0 means to convert manually
  ]
  
  class <<self
    def all
      UNITS.map{|unit_hash| new(unit_hash)}
    end
    def find(id)
      new(UNITS[id])
    end
    def find_by_imperial(imp)
      unit_hash = UNITS.find{|unit| unit[:imperial] == imp}
      new(unit_hash) if unit_hash
    end
  end
  
  def id
    UNITS.find_index{|unit| unit[:imperial] == @unit_hash[:imperial]}
  end

  def initialize(unit_hash)
    @unit_hash = unit_hash
  end
  
  def convert_to_metric(imperials)
    if @unit_hash[:imperials_per_metric] == 0
      if @unit_hash[:imperial] == "F"
        return convert_to_celsius(imperials)
      end
    else
      return imperials * @unit_hash[:imperials_per_metric]
    end
  end
  
  def convert_to_celsius(f)
    return (f - 32) * (5.0/9)
  end
  
  def method_missing(meth, *args)
    if @unit_hash.has_key? meth
      return @unit_hash[meth]
    else
      super
    end
  end
end