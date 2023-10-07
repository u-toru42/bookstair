require 'rails_helper'

RSpec.describe "messages/edit", type: :view do
  let(:message) {
    Message.create!(
      sender: "MyText",
      content: "MyText"
    )
  }

  before(:each) do
    assign(:message, message)
  end

  it "renders the edit message form" do
    render

    assert_select "form[action=?][method=?]", message_path(message), "post" do

      assert_select "textarea[name=?]", "message[sender]"

      assert_select "textarea[name=?]", "message[content]"
    end
  end
end
