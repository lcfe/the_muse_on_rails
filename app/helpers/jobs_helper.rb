module JobsHelper
  def level_options(selected_options)
    option_names = extract_option_names('level.yml')
    options_for_select(option_names, selected_options)
  end

  def category_options(selected_options)
    option_names = extract_option_names('category.yml')
    options_for_select(option_names, selected_options)
  end

  private def extract_option_names(filename)
    config_file_path = File.join(search_options_config_directory, filename)
    config_file = File.open(config_file_path)
    YAML.load(config_file.read)
  end

  private def search_options_config_directory
    Rails.root.join('config', 'search_options')
  end
end
