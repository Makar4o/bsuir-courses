class Version
  def initialize(versions, gem_version, parameter)
    @gem_version = []
    gem_version.each { |version| @gem_version.push(Gem::Version.new(version))}
    @parameter = parameter
    @versions = []
    versions.each { |version| @versions.push(Gem::Version.new(version))}
    @find_versions = (0..versions.size - 1).to_a
  rescue Exception
    puts "Incorrect version!"
    exit
  end

  def find
    @parameter.each do |p|
      find_current_version = []
      index = @parameter.index(p)
      case p
      when '>=' then
        @versions.each do |version| 
          if version >= @gem_version[index]
            find_current_version.push(@versions.index(version))
          end
        end
        @find_versions -= @find_versions - find_current_version
      when '<=' then
        @versions.each do |version| 
          if version <= @gem_version[index]
            find_current_version.push(@versions.index(version))
          end
        end
        @find_versions -= @find_versions - find_current_version
      when '>' then
        @versions.each do |version| 
          if version > @gem_version[index]
            find_current_version.push(@versions.index(version))
          end
        end
        @find_versions -= @find_versions - find_current_version
      when '<' then
        @versions.each do |version| 
          if version < @gem_version[index]
            find_current_version.push(@versions.index(version))
          end
        end
        @find_versions -= @find_versions - find_current_version
      when '~>' then
        @versions.each do |version| 
        if version >= @gem_version[index] && version < @gem_version[index].bump
            find_current_version.push(@versions.index(version))
          end
        end
        @find_versions -= @find_versions - find_current_version
      end

      if @find_versions.empty?
        puts 'Version not found!'
        exit
      end
    end
  end

  def get_find_versions
    return @find_versions
  end
end
