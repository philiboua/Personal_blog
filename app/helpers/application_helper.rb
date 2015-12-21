module ApplicationHelper

  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      Pygments.highlight(code, lexer: language)
    end
  end

  def markdown(content)
    renderer = HTMLwithPygments.new(hard_wrap: true, filter_html: true)
    options = { 
      autolink: true, 
      no_intra_emphasis: true, 
      disable_indented_code_blocks: true, 
      fenced_code_blocks: true, 
      lax_html_blocks: true, 
      strikethrough: true, 
      superscript: true, 
    }
    preserve(Redcarpet::Markdown.new(renderer, options).render(content).html_safe)
  end

  def active_link(path)
    'active_link' if current_page?(path)
  end

  def root_active_link(path)
    'active_link' if (current_page?(path) || current_page?(root_path))   
  end

end
