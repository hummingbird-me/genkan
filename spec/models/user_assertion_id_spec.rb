require 'rails_helper'

RSpec.describe UserAssertionID do
  it { should define_enum_for(:source) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:assertion) }
  it { should validate_presence_of(:source) }
end
