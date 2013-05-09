
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

  def generate_ini(sections)
    lines = []
    sections.each do |sectionname, entries|
      next if entries.nil? or entries == '' # ability to overwrite existing entries with an empty string to skip them
      lines << ''
      lines << "[#{sectionname}]"
      entries.each do |key, value|
        lines << "#{key} = #{value}"
      end
    end
    lines << ''
    lines.join "\n"
  end

  def generate_lines(lines)
    lines.join("\n") + "\n"
  end
end
