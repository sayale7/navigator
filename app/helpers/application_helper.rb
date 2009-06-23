# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def fckeditor_textarea_tag(name, content = nil, options = {})
    id = options[:id].blank? ? name : options[:id]

    cols = options[:cols].nil? ? '' : "cols='" + options[:cols] + "'"
    rows = options[:rows].nil? ? '' : "rows='" + options[:rows] + "'"

    width = options[:width].nil? ? '100%' : options[:width]
    height = options[:height].nil? ? '100%' : options[:height]

    toolbarSet = options[:toolbarSet].nil? ? 'Default' : options[:toolbarSet]

    if options[:ajax]
      inputs = "<input type='hidden' id='#{id}_hidden' name='#{name}'>\n" +
               "<textarea id='#{id}' #{cols} #{rows} name='#{id}'>#{content}</textarea>\n"
    else
      inputs = "<textarea id='#{id}' #{cols} #{rows} name='#{name}'>#{content}</textarea>\n"
    end

    base_path = ActionController::Base.relative_url_root.to_s + '/javascripts/fckeditor/'
    inputs +
    javascript_tag( "var oFCKeditor = new FCKeditor('#{id}', '#{width}', '#{height}', '#{toolbarSet}');\n" +
                    "oFCKeditor.BasePath = \"#{base_path}\"\n" +
                    "oFCKeditor.Config['CustomConfigurationsPath'] = '../../fckcustom.js';\n" +
                    "oFCKeditor.ReplaceTextarea();\n")
  end
end
