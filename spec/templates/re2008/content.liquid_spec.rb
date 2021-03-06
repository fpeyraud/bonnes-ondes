require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "re2008/content" do

  fixtures :contents, :episodes

  before do
    @template = Template.new :slug => 're2008'

    @content = contents(:first)
    @episode = @content.episode

    @content_liquid = @content.to_liquid
    # to use always the same instance
    @content.stub!(:to_liquid).and_return(@content_liquid) 
  end

  def render_template(view, object)
    template.finder.view_paths = ["#{RAILS_ROOT}/templates"]
    assigns[:theme] = @template
    assigns[view.to_sym] = object # TODO see why render locals are ignored ?
    render :layout => false, :template => "#{@template.slug}/#{view}",
      :locals => { view.to_sym => object }
  end
  
  it "should have title 'Esperanzah! 2008 - Radio - Ecouter content_episode_title - content_name'" do
    @content.name = 'content_name'
    @episode.title = 'content_episode_title'
    
    render_template :content, @content
    response.should have_tag('title', 'Esperanzah! 2008 - Radio - Ecouter content_episode_title - content_name')
  end

  it "should display embedded player when content is available" do
    @content_liquid.stub!(:available?).and_return(true)

    @content_liquid.should_receive(:embedded_player).and_return("<embed id='test'/>")
    render_template :content, @content
    response.should have_tag('embed[id=test]')
  end

  it "should not display embedded player when content isn't available" do
    @content_liquid.stub!(:available?).and_return(false)

    @content_liquid.should_not_receive(:embedded_player)
    render_template :content, @content
    response.should_not have_tag('embed')
  end

  it "should display 'Contenu non disponible' when content isn't available" do
    @content_liquid.stub!(:available?).and_return(false)
    render_template :content, @content
    response.should have_tag('p',/ce contenu n'est plus disponible/i)
  end

end
