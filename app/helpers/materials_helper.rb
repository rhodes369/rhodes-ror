
module MaterialsHelper
  def print_standard(standard)
    "ASTM #{standard.code} #{standard.description}"
  end
  
  def print_standard_value(standard_value, unit_type=:imperial)
    value = (unit_type == :imperial ? standard_value.imperials : standard_value.metrics)
    precision_opts = { precision: 2, delimiter: ',', strip_insignificant_zeros: true }
    
    "#{number_with_precision(value, precision_opts)} #{standard_value.standard.unit.send(unit_type)}"
  end
end