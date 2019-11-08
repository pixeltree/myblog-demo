require 'rails_helper'

RSpec.describe "welcome/index.html.erb", type: :view do
  it 'says hello world' do
    render

    expect(rendered).to match /hello world/
  end
end
