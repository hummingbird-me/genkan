# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserName do
  it { should define_enum_for(:status) }
  it { should define_enum_for(:kind) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:kind) }
  it { should have_many(:passwords) }
end
