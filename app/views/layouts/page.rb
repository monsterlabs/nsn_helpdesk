class Views::Layouts::Page < Erector::RailsWidget
  
  @@js = []  
  def self.js(*files)
    files.each {|f| @@js << f unless @@js.include?(f) }
  end

  @@css = []
  def self.css(*files)
    files.each {|f| @@css << f unless @@css.include?(f) }
  end

  @@styles = []
  def self.style(txt)
    @@styles << txt
  end

  @@scripts = []
  def self.script(txt)
    @@scripts << txt
  end

  @@jqueries = []
  def self.jquery(txt)
    @@jqueries << txt
  end

  def doctype
    '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
       "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'
  end

  # override me
  def page_title
    "page"
  end

  def content
    rawtext doctype
    html :xmlns => 'http://www.w3.org/1999/xhtml', 'xml:lang' => 'en', :lang => 'en' do
      head do
        head_content
      end
      body do
        body_content
      end
    end
  end

  # override me (or instantiate Page with a block)
  def body_content
    instance_eval(&@block) if @block
  end

  def head_content
    meta 'http-equiv' => 'content-type', :content => 'text/html;charset=UTF-8'
    title page_title
    @@js.each do |file|
      script :type=>"text/javascript", :src => file
    end
    @@css.each do |file|
      link :rel=>"stylesheet", :href => file, :type => "text/css", :media => "all"
    end
    inline_styles
    inline_scripts
  end

  def inline_styles
    style :type=>"text/css", 'xml:space' => 'preserve' do
      rawtext "\n"
      @@styles.each do |txt|
        rawtext "\n"
        rawtext txt
      end
    end
  end
  
  def inline_scripts
    javascript do
      @@scripts.each do |txt|
        rawtext "\n"
        rawtext txt
      end
      @@jqueries.each do |txt|
        rawtext "\n"
        rawtext "$(document).ready(function(){\n"
        rawtext txt
        rawtext "\n});"
      end
    end
  end

  style <<-STYLE
    img {border: none}
    .right {float: right;}
    .clear {clear: both;}
  STYLE
  
end

class Erector::Widget
  def jquery(txt)
    javascript do
      rawtext "\n"
      rawtext "$(document).ready(function(){\n"
      rawtext txt
      rawtext "\n});"
    end
  end
end
