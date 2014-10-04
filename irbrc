%w[rubygems awesome_print interactive_editor].each do |gem|
  begin
    require gem
  rescue LoadError
  end
end
