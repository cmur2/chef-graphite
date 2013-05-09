
class Chef::Node
  def generate_local_settings
    return nil if self['graphite']['webapp']['local_settings'].nil?
    
    lines = []
    self['graphite']['webapp']['local_settings'].each do |name, value|
      lines << "#{name} = #{value}"
    end
    lines << ''
    lines.join "\n"
  end
end
