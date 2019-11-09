require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  before(:each) do
    assign(:posts, [
      Post.create!(
        :title => "Title",
        :body => "MyText"
      ),
      Post.create!(
        :title => "Title",
        :body => "MyText"
      )
    ])
  end

  it "renders a list of posts" do
    render
    assert_select "h2", count: 2
  end
end
